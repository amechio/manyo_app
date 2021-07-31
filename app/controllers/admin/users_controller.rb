class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    # @users = User.all.page(params[:page])
    @users = User.select(:id, :name).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました！"
    else
      render :edit, notice:"管理ユーザーがいなくなります！"
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"削除しました！"
    else
      redirect_to admin_users_path, notice:"管理ユーザーがいなくなります！"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    if current_user.admin != true
      redirect_to new_session_path, notice: "権限がありません！"
    end
  end
end
