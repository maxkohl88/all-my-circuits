class RenameUserReferencesOnChat < ActiveRecord::Migration
  def change
    rename_column :chats, :u1, :u1_id
    rename_column :chats, :u2, :u2_id
  end
end
