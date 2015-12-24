class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.references :ticket_type, index: true, foreign_key: true
      t.integer :quantity
      t.integer :total

      t.timestamps null: false
    end
  end
end
