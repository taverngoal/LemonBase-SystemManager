class Admin::UsersController < Admin::BaseController
  add_breadcrumb :controller, action: :index
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    add_breadcrumb :index, action: :index
    @admin_users =initialize_grid(User.all, per_page: 20)
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    add_breadcrumb :show, action: :show
  end

  # GET /admin/users/new
  def new
    add_breadcrumb :new, action: :new
    @admin_user = User.new
  end

  # GET /admin/users/1/edit
  def edit
    add_breadcrumb :edit, action: :edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @admin_user = User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @admin_user] }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update_attributes(admin_user_params)
        format.html { redirect_to [:admin, @admin_user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @admin_user] }
      else
        flash[:error] =  @admin_user.errors.as_json
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_user
    @admin_user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :nick, :birth, :address, :phone)
  end
end
