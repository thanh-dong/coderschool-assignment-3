class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @max_ticket = 1
    @ticket = 0
  end
end
