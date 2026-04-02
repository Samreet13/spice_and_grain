class CartController < ApplicationController
  def add
    session[:cart] ||= {}

    product_id = params[:id].to_s

    if session[:cart][product_id]
      session[:cart][product_id] += 1
    else
      session[:cart][product_id] = 1
    end

    redirect_to products_path, notice: "Added to cart"
  end

  def show
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def remove
    session[:cart].delete(params[:id])
    redirect_to cart_path, notice: "Removed item"
  end

  def update
    session[:cart][params[:id]] = params[:quantity].to_i
    redirect_to cart_path
  end
end