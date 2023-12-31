class TasksController < ApplicationController
  before_action :set_task, only: %i[ update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.order(created_at: :desc)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  # def update
  #   respond_to do |format|
  #     if @task.update(task_params)
  #       format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update 
    #@task.done = true Eu marco a tarefa e posso também desmarcar na linha abaixo
    @task.done = !@task.done
    @task.save

    redirect_to task_url
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :done)
    end
end
