class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: nil
    else
      render json: {:error => 'Failed to create user'}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find_by(id: params[:id])
    @events = Event.where(:user_id => @user.id)
    @events.each do |event|
      event.destroy
    end
    @user.destroy!
    render json: ("User #{params[:id]} and events deleted"), status: :ok

  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password_digest)
    end
end
