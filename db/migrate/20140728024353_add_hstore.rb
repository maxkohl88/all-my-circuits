class AddHstore < ActiveRecord::Migration
  def change

    def up
      execute 'CREATE EXTENSION hstore'
    end

    def down
      execute 'DROP EXTENSION hstore'
    end
  end
end
