class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy ]

  def new
  end

  # GET /events
  def index
    @events = Event.all
    render json: @events
  end

  # GET /events/1
  def show
    id = params.extract_value(:id)
    @event = Event.find(id)

    puts(render json: @event)
#     puts(@event)
  end

  # POST /events
  def create
    puts(event_params)
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    id = params.extract_value(:id)
    @user = User.find_by(event_params[:user_id])
    @event = @user.events.find_by(id)
    if @event
      if @event.update(event_params)
        render json: @event
      end
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
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
