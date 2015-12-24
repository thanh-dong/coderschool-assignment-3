class EventsController < ApplicationController
  def index
    @keyword = params[:search] || ''
    @events = Event.search(@keyword)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @categories = Category.all
    @venues = Venue.all
  end

  def create
    @event = Event.new(event_params)
    @event.published = false
    @event.starts_at = DateTime.strptime(params[:event][:starts_at], '%m/%d/%Y %I:%M %p')
    @event.ends_at = DateTime.strptime(params[:event][:ends_at], '%m/%d/%Y %I:%M %p')
    @event.category_id = params[:event][:category_id].to_i
    @event.venue_id = params[:event][:venue_id].to_i
    @event.created_by = params[:event][:create_by].to_i
    if @event.save
      redirect_to root_path, flash: {success: "Your event has been created successfully"}
    else
      redirect_to root_path, flash: {error: "Please try again"}
    end
  end

  def get_my_events
    @events = Event.where("created_by = ?", session[:user_id])
    render 'my_events'
  end

  def publish
    @event = Event.find(params[:id])
    if @event.ticket_types.count > 0
      @event.published ^= true
      @event.save
      get_my_events
    else
      redirect_to my_events_path, flash: {error: "Your event is not ready to publish yet"}
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :extended_html_description, :hero_image_url)
  end

end
