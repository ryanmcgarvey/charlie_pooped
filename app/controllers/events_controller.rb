class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def create
    Event.create(params[:event])
    redirect_to events_path
  end

  def destroy
    Event.find(params[:id]).destroy!
    redirect_to events_path
  end

end
