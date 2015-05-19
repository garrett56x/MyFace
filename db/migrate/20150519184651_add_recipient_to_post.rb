class AddRecipientToPost < ActiveRecord::Migration
  def change
    add_column :posts, :recipient, :integer
  end
end
