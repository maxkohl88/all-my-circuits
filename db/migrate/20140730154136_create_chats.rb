class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :u1, :u2, references: :users, null: false
      t.boolean :u1_like, :u2_like, :blocked, default: false
    end
  end
end
