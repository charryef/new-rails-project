class ChargesController < ApplicationController
  def create
     # Creates a Stripe Customer object, for associating
     # with the charge
     @user = current_user
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: 1500,
       description: "Blocipedia Premium Membership - #{current_user.email}",
       currency: 'usd'
     )

    current_user.update_attribute(:role, 'premium')
     flash[:notice] = "Thanks for upgrading to Premium, #{current_user.email}! You can now create and edit private wikis."
     redirect_to user_path(current_user)

     # current_user.premium!
     # current_user.save

     # Stripe will send back CardErrors, with friendly messages
     # when something goes wrong.
     # This `rescue block` catches and displays those errors.
     rescue Stripe::CardError => e
       flash[:alert] = e.message
       redirect_to new_charge_path
 end

 def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.email}",
      amount: 1500
    }
  end
end
