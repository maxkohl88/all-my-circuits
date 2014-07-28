class AddGithubColumnsToUser < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :name, :string, null: false
  end

  def down
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :name
  end
end
