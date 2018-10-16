# Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   publishable_key: Rails.application.credentials[:PUBLISHABLE_KEY],
   secret_key: Rails.application.credentials[:SECRET_KEY]
 }

 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.application.credentials[:SECRET_KEY]
