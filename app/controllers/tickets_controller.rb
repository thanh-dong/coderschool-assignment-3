class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @max_ticket = 1
    @ticket = 0
  end

  def new_ticket_type
    @event_id = params[:event_id]
    @ticket = TicketType.new
    render '/tickets/new_ticket_type'
  end

  def create
    @ticket = TicketType.new
    @ticket.name = params[:ticket_type][:name]
    @ticket.price = params[:ticket_type][:price].to_i
    @ticket.max_quantity = params[:ticket_type][:max_quantity].to_i
    @ticket.event_id = params[:ticket_type][:event_id].to_i
    @ticket.sold_quantity = 0

    if @ticket.save
      redirect_to my_events_path, flash: {success: "Ticket type was created successfully"}
    else
      redirect_to new_ticket_type_path(params[:ticket_type][:event_id].to_i), flash: {error: "Opp! Somethings went wrong!"}
    end
  end
end
