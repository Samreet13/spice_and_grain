class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
    @provinces = Province.all
  end

  def create
    cart = session[:cart] || {}
    products = Product.find(cart.keys)

    subtotal = 0

    products.each do |product|
      price = product.on_sale ? product.sale_price : product.price
      quantity = cart[product.id.to_s].to_i
      subtotal += price * quantity
    end

    # ✅ USE SAVED PROVINCE OR FALLBACK
    province = if current_customer.province.present?
                 current_customer.province
               else
                 Province.find(params[:province_id])
               end

    # 🔥 BONUS: SAVE ADDRESS IF USER ENTERS IT DURING CHECKOUT
    if current_customer.address.blank? && params[:address].present?
      current_customer.update(
        address: params[:address],
        city: params[:city],
        province_id: params[:province_id]
      )
    end

    # ✅ TAX CALCULATIONS
    gst = subtotal * province.gst
    pst = subtotal * province.pst
    hst = subtotal * province.hst

    total = subtotal + gst + pst + hst

    # ✅ CREATE ORDER
    @order = Order.create!(
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      total: total,
      province: province,
      customer: current_customer
    )

    # ✅ CREATE ORDER ITEMS
    products.each do |product|
      quantity = cart[product.id.to_s].to_i
      price = product.on_sale ? product.sale_price : product.price

      OrderItem.create!(
        order: @order,
        product: product,
        quantity: quantity,
        price: price
      )
    end

    # ✅ CLEAR CART
    session[:cart] = {}

    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end
end