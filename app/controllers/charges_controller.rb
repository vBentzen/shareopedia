class ChargesController < ApplicationController

  class Amount
    def Amount.default
      15_00
    end
  end



  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: Amount.default
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )



    # Where the real magic happens
    charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: Amount.default,
        description: "BigMoney Membership - #{current_user.email}",
        currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')
    flash[:notice] = "Thanks for all the money, #{current_user.email}! You are now a premium user."
    redirect_to edit_user_registration_path

      # Stripe will send back CardErrors, with friendly messages
      # when something goes wrong.
      # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
end
