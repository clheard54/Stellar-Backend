class Api::V1::EventsController < ApplicationController
    before_action :authorized

  def index
    @events = Event.all
    render json: @events
  end

  def create
    calendar = User.find_by(id: event_params[:user_id]).calendar
    if !calendar
      calendar = Calendar.create(user_id: event_params[:user_id])
    end
    full_params = {"title"=> event_params[:title], "date"=> event_params[:date], "details"=> event_params[:details], 'time'=> event_params[:time], "user_id"=> event_params[:user_id], :calendar_id => calendar.id}
    puts full_params
    @event = Event.new(full_params)
    # byebug
    if @event.valid?
        @event.save
        render json: { event: EventSerializer.new(@event)}
    else
        render json: { error: 'failed to create event' }, status: :not_acceptable
    end
  end

  def show 
    @event = Event.find(params[:id])
    if @event
      render json: @event
    else 
      render json: { error: 'That event does not exist'}, status: :not_acceptable
    end
  end

  def edit 
    @event = Event.find(params[:id])
    if @event
      render json: @event 
    else 
      render json: { error: 'That event does not exist'}, status: :not_acceptable
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    render json: @event 
  end

  def delete
    @event = Event.find(params[:id])
    if @event 
      @event.destroy 
      render json: {message: "Event successfully deleted"}
    else 
      render json: {message: 'Could not destory event'}, status: :not_acceptable
    end
  end
  



  private

  def event_params
    params.require(:event).permit(:title, :date, :details, :time, :user_id)
  end
end
