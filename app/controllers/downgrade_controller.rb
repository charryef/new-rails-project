class DowngradeController < ApplicationController
  def downgrade
    current_user.role = 'standard'
    current_user.save!
    flash[:notice] = "#{current_user.email} was downgraded to standard successfully."
    redirect_to new_charge_path
  end
end
