class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    if current_user == nil
      @user = User.new
    else
      redirect_to new_session_path, notice: "ログアウトしてください！"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to tasks_path, notice: "権限がありません！"
    end
  end

  def edit
    unless current_user.id == @user.id
      redirect_to user_path(id: @user.id), notice: "権限がありません！"
    else
      @user = User.find(params[:id])
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(id: @user.id), notice: "編集しました！"
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
