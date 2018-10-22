class DowngradeController < ApplicationController
  def downgrade
    current_user.role = 'standard'
    current_user.save!
    current_user.wikis.each do |pubwiki|
      pubwiki.update_attribute(:private, false)
    end
    flash[:notice] = "#{current_user.email} was downgraded to standard successfully."
    redirect_to new_charge_path
  end
end
