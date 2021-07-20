class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
    @tasks = @tasks.order(created_at: :desc) if params[:sort_limit].nil?
    @tasks = @tasks.order(limit: :asc) if params[:sort_limit]
    @tasks = @tasks.title_search(params[:title]) if params[:title].present?
    @tasks = @tasks.status_search(params[:status]) if params[:status].present?
    @tasks = @tasks.priority_search(params[:priority]) if params[:priority].present?
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
    params.require(:task).permit(:title, :content, :limit, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
