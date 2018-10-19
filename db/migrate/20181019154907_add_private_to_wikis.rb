class AddPrivateToWikis < ActiveRecord::Migration[5.2]
  def change
    add_column :wikis, :private, :boolean
  end
end
