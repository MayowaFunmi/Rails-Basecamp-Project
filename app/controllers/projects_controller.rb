class ProjectsController < ApplicationController
  #before_action :set_project, only: %i[ show edit update destroy ]
  # i commented this out as it renders error page after executing destroy route
  before_action :authenticate_user!

  # GET /projects or /projects.json
  def index
    if current_user.admin == true
      @projects = Project.all
    else
      @projects = Project.where(user: current_user)
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.save
    redirect_to projects_path

    #respond_to do |format|
      #if @project.save
        #format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        #format.json { render :show, status: :created, location: @project }
      #else
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @project.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project = Project.find(params[:id])

    if current_user == @project.user || current_user.admin == true
      @project.destroy
      redirect_to projects_path, notice: "Project deleted successfully"
    else
      redirect_to project_url, alert: "You are not authorized to delete this project"
    end

    #respond_to do |format|
      #format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
