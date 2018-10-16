class ChargesController < ApplicationController
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
       amount: 1500,
       description: "Blocipedia Premium Membership - #{current_user.email}",
       currency: 'usd'
     )

    current_user.update_attribute(:role, 'premium')
     flash[:notice] = "Thanks for your payment, #{current_user.email}! With your premium account, you can now create and edit private wikis."
     redirect_to wikis_path

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
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: 1500
    }
  end

  def downgrade
    current_user.role = 'standard'
    current_user.save!
    flash[:notice] = "#{current_user.email} was downgraded to standard successfully."
    redirect_to new_charge_path
  end
end
