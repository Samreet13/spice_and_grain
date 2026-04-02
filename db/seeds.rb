require 'faker'
require 'csv'

puts "Cleaning database..."

OrderItem.destroy_all
Order.destroy_all
Customer.destroy_all

ProductCategory.destroy_all if defined?(ProductCategory)

Product.destroy_all
Category.destroy_all
Page.destroy_all
Province.destroy_all

puts "Creating categories..."

grains = Category.create!(name: "Grains")
pulses = Category.create!(name: "Pulses")
beverages = Category.create!(name: "Beverages")
spices = Category.create!(name: "Spices")

categories = [grains, pulses, beverages, spices]

puts "Creating provinces..."

Province.create!(name: "Alberta", gst: 0.05, pst: 0, hst: 0)
Province.create!(name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0)
Province.create!(name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0)
Province.create!(name: "New Brunswick", gst: 0, pst: 0, hst: 0.15)
Province.create!(name: "Newfoundland and Labrador", gst: 0, pst: 0, hst: 0.15)
Province.create!(name: "Nova Scotia", gst: 0, pst: 0, hst: 0.15)
Province.create!(name: "Ontario", gst: 0, pst: 0, hst: 0.13)
Province.create!(name: "Prince Edward Island", gst: 0, pst: 0, hst: 0.15)
Province.create!(name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0)
Province.create!(name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0)

Province.create!(name: "Northwest Territories", gst: 0.05, pst: 0, hst: 0)
Province.create!(name: "Nunavut", gst: 0.05, pst: 0, hst: 0)
Province.create!(name: "Yukon", gst: 0.05, pst: 0, hst: 0)

puts "Creating products from CSV..."

csv_products = CSV.read(Rails.root.join('db/products.csv'), headers: true)

csv_products.each do |row|
  product = Product.create!(
    name: row['name'],
    description: row['description'],
    price: row['price'],
    stock_quantity: rand(5..50),
    on_sale: [true, false].sample,
    sale_price: rand(2.0..15.0).round(2)
  )

  category = Category.find_by(name: row['category'])
  product.categories << category if category
end

puts "Adding extra products to reach 200..."

remaining = 200 - Product.count

remaining.times do
  product = Product.create!(
    name: "#{Faker::Food.ingredient} #{Faker::Number.unique.number(digits: 3)}",
    description: Faker::Food.description,
    price: rand(3.0..20.0).round(2),
    stock_quantity: rand(5..50),
    on_sale: [true, false].sample,
    sale_price: rand(2.0..15.0).round(2)
  )

  product.categories << categories.sample
end

puts "Creating pages..."

Page.create!(title: "About", content: "This is about our store.")
Page.create!(title: "Contact", content: "Contact us at email@example.com")

puts "Seeded #{Product.count} products!"AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?