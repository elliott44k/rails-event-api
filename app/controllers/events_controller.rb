class EventsController < ApplicationController

  # GET /events
  def index
    @events = Event.all
    if @events
      render json: @events, status: :ok
    else
      render json: {:error => 'Failed to find events'}, status: :internal_server_error
    end
  end

  # GET /events/:id
  def show
    @event = Event.find_by(id: params[:id])
    if @event
      render json: @event, status: :ok
    else
      render json: {:error => 'Failed to find event'}, status: :unprocessable_entity
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created, location: nil
    else
      render json: {:error => 'Failed to create event'}, status: :unprocessable_entity
    end
  end

  # PUT /events/:id
  def update
    @user = User.find_by(id: event_params[:user_id])
    @event = @user.events.find_by(id: params[:id])
    if @event
      if @event.update(event_params)
        render json: @event, status: :ok
      end
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/:id
  def destroy
    @user = User.find_by(id: event_params[:user_id])
    @event = @user.events.find_by(id: params[:id])
    if @event
      if @event.destroy!
        render json: ("Event #{params[:id]} deleted"), status: :ok
      end
    else
      render json: {:error => 'Failed to find deletable event'}, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :location, :start_time, :end_time, :user_id)
    end
end
