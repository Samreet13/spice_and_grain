class PaymentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    order = Order.find(params[:order_id])

    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    payment_intent = Stripe::PaymentIntent.create(
      amount: (order.total * 100).to_i,
      currency: "cad",
      automatic_payment_methods: {
        enabled: true
      },
      metadata: {
        order_id: order.id,
        customer_id: current_customer.id
      }
    )

    order.update!(stripe_payment_id: payment_intent.id)

    render json: {
      client_secret: payment_intent.client_secret
    }

  rescue Stripe::StripeError => e
    render json: {
      error: e.message
    }, status: :unprocessable_entity
  end

  def confirm
    order = Order.find(params[:order_id])

    order.update!(status: :paid)

    render json: { success: true }
  end
end