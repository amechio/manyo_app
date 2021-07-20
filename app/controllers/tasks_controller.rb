class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # if params[:sort_limit]
    #   @tasks = Task.all.order(limit: :desc)
    # elsif params[:title].present? && params[:status].present?
    #   @tasks = Task.all.search(params[:title])
    #   @tasks = Task.where(status: params[:status])
    # elsif params[:title].present?
    #   @tasks = Task.where(title: params[:title])
    #   # @tasks = Task.all.search(params[:title])
    # elsif params[:status].present?
    #   @tasks = Task.where(status: params[:status])
    # else
    #   @tasks = Task.all.order(created_at: :desc)
    # end

    @tasks = Task.all
    @tasks = @tasks.order(created_at: :desc) if params[:sort_limit].nil?
    @tasks = @tasks.order(limit: :asc) if params[:sort_limit]
    @tasks = @tasks.title_search(params[:title]) if params[:title].present?
    @tasks = @tasks.status_search(params[:status]) if params[:status].present?


    # @tasks = Task.all.order(created_at: :desc)
    # @tasks = Task.all.order(limit: :desc) if params[:sort_limit]
    # @tasks = Task.all.search(params[:title]) if params[:title].present?
    # # @tasks = Task.all.search(params[:status]) if params[:status].present?
    # @tasks = Task.where(status: params[:status]) if params[:status].present?
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "作成しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！"
  end


  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
