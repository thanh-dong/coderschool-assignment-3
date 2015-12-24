class OrdersController < ApplicationController
  def show
  end

  def create
    if params[:order][:submit_type] == 'book'
      ticket_type = params[:order][:ticket_type]
      quantity = params[:order][:quantity]
      if ticket_type.blank? || quantity.blank?
        redirect_to new_event_ticket_path(event_id: params[:order][:event]), flash: {error: "Please choose your ticket before booking."}
        return
      end

      # TODO: create ticket that links to order
      ticket = TicketType.find ticket_type.to_i
      ticket.orders << Order.new(name: ticket.name, quantity: quantity.to_i, total: ticket.price * quantity.to_i)
      ticket.sold_quantity += quantity.to_i

      if ticket.save
        redirect_to root_path, flash: {success: "Your ticket have been booked successfully."}
      else
        redirect_to new_event_ticket_path(event_id: params[:order][:event]), flash: {error: "Oop! Please try again."}
      end
    else
      @event = @event = Event.find(params[:order][:event])
      ticket_id = params[:order][:ticket_type]
      if ticket_id.blank?
        @ticket = 0
        @max_ticket = 1
      else
        @ticket = TicketType.find ticket_id.to_i
        remaining_ticket = @ticket.max_quantity - @ticket.sold_quantity
        @max_ticket = remaining_ticket > 10 ? 10 : remaining_ticket
      end

      render "/tickets/new"
    end


  end

end
