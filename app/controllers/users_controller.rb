require 'securerandom'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    random_string = SecureRandom.hex
    @user.unique_code = random_string
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end


  def get_by_unique_code_and_device_code
    @user = User.where(unique_code:params[:unique_code],device_code:params[:device_id])
    if @user.present?
      render json: @user[0]
    else
      render json: {message:"Data not found"},status: :not_found
    end
  end

  def get_by_unique_code
    @user = User.where(unique_code:params[:unique_code])
    if @user.present?
      render json: @user[0]
    else
      render json: {message:"Data not found"},status: :not_found
    end
  end

  def get_by_device_code
    @user = User.where(device_code:params[:device_code])
    if @user.present?
      render json: @user[0]
    else
      render json: {message:"Data not found"},status: :not_found
    end
  end

  def update_by_unique_code
    @params = request.params
    if User.where(:unique_code => @params['user']['unique_code']).update_all(device_code: @params['user']['device_code'])
      render json: {message:'successfully updated device code'}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :mobile, :user_name, :password, :unique_code, :device_code)
    end
end
