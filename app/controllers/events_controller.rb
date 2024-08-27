class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy ]

  def new
  end

  # GET /events
  def index
    @events = Event.all
    if @events
      render json: @events, status: :ok
    else
      render json: {:error => 'Failed to find events'}, status: :internal_server_error
    end
  end

  # GET /events/1
  def show
    id = params.extract_value(:id)
    @event = Event.find_by(id: id)
    if @event
      render json: @event, status: :ok
    else
      render json: {:error => 'Failed to find event'}, status: :unprocessable_entity
    end
  end

  # POST /events
  def create
    puts(event_params)
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: {:error => 'Failed to create event'}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    id = params.extract_value(:id)
    @user = User.find_by(id: event_params[:user_id])
    @event = @user.events.find_by(id: id)
    if @event
      if @event.update(event_params)
        render json: @event, status: :ok
      end
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    id = params.extract_value(:id)
    @user = User.find_by(id: event_params[:user_id])
    @event = @user.events.find_by(id: id)

    if @event
      if @event.destroy!
        render json: ("Event #{id} deleted"), status: :ok
      end
    else
      if @event.nil?
        render json: {:error => 'Failed to find deletable event'}, status: :unprocessable_entity
      else
        puts(@event.errors)
          render json: @event.errors, status: :internal_server_error
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :description, :location, :start_time, :end_time, :user_id)
    end
end
