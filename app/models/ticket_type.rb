class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :orders
end
