class CreateStocks < ActiveRecord::Migration
  def up
    create_table :stocks do |t|
      t.string :name
      t.string :ticker
      t.decimal :value
    end
  end

  def down
    drop_table :stocks
  end
end
