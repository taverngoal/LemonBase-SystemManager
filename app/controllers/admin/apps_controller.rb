class Admin::AppsController < ApplicationController
  before_action :set_admin_app, only: [:show, :edit, :update, :destroy]

  # GET /admin/apps
  # GET /admin/apps.json
  def index
    @admin_apps = App.all
  end

  # GET /admin/apps/1
  # GET /admin/apps/1.json
  def show
  end

  # GET /admin/apps/new
  def new
    @admin_app = App.new
  end

  # GET /admin/apps/1/edit
  def edit
  end

  # POST /admin/apps
  # POST /admin/apps.json
  def create
    @admin_app = App.new(admin_app_params)

    respond_to do |format|
      if @admin_app.save
        format.html { redirect_to [:admin, @admin_app], notice: 'App was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @admin_app] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @admin_app].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/apps/1
  # PATCH/PUT /admin/apps/1.json
  def update
    respond_to do |format|
      if @admin_app.update(admin_app_params)
        format.html { redirect_to [:admin, @admin_app], notice: 'App was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_app }
      else
        format.html { render :edit }
        format.json { render json: @admin_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/apps/1
  # DELETE /admin/apps/1.json
  def destroy
    @admin_app.destroy
    respond_to do |format|
      format.html { redirect_to admin_apps_url, notice: 'App was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_app
    @admin_app = App.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_app_params
    params.require(:app).permit(:name, :access_key, :secret_key, :permission_level, :enable)
  end
end
