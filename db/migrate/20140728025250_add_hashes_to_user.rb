class AddHashesToUser < ActiveRecord::Migration
  def change
    add_column :users, :basic_info, :hstore
    add_column :users, :summary, :text
    add_column :users, :non_searchable_details, :hstore
    add_column :users, :searchable_details, :hstore
  end
end
