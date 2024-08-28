class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: nil
    else
      render json: { :error => 'Failed to create user' }, status: :unprocessable_entity
    end
    # Catch if no user details given
  rescue ActionDispatch::Http::Parameters::ParseError, ActionController::ParameterMissing
    render json: { :error => 'Correct user details required' }, status: :unprocessable_entity
  end

  # DELETE /users/1
  def destroy
    @user = User.find_by(id: params[:id])
    if @user
      @events = Event.where(:user_id => @user.id)
      @events.each do |event|
        event.destroy
      end
      @user.destroy!
      render json: ("User #{params[:id]} and events deleted"), status: :ok
    else
      render json: ("Failed to find user to delete"), status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end

end
