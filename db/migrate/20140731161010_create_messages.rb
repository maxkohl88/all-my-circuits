class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, null: false
      t.references :chat, null: false
      t.text :content, default: ""
      t.timestamps
    end
  end
end
