class ChangeCloumnsNotNullUserAndPhoto < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :password_digest, :string, null: false
    change_column :photos, :user_id, :integer, null: false
    change_column :photos, :title, :string, null: false
    change_column :photos, :file_name, :string, null: false
  end
end
