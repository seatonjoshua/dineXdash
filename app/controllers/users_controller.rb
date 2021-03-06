class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :require_login, only: [:new, :create]
  before_filter :admin_user, only: [:index, :destroy]
  before_filter :ensure_current_user_or_admin, only: [:edit, :update, :show]


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

 
  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(:root, notice: 'User was successfully created')
      auto_login(@user)
    else
      render action: 'new'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def ensure_current_user_or_admin
      unless current_user.id == @user.id || current_user.admin?
        redirect_to :back, alert: "You can't mess with another user!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:tip, :email, :password, :password_confirmation)
    end

end
