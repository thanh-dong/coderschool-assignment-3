class AddSoldQuantityToTicketTypes < ActiveRecord::Migration
  def change
    add_column :ticket_types, :sold_quantity, :integer
  end
end
