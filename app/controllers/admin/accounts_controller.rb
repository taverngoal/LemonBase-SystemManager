class Admin::AccountsController < Admin::BaseController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action :set_admin_account, only: [:show, :edit, :update, :destroy]

  # GET /admin/accounts
  # GET /admin/accounts.json
  def index
    @admin_accounts =initialize_grid(Account.where('is_public = ? OR officer = ?', true, current_user.id), per_page: 20)
  end

  # GET /admin/accounts/1
  # GET /admin/accounts/1.json
  def show
  end

  # GET /admin/accounts/new
  def new
    @admin_account = Account.new
  end

  # GET /admin/accounts/1/edit
  def edit
  end

  # POST /admin/accounts
  # POST /admin/accounts.json
  def create
    @admin_account = Account.new(admin_account_params)
    @admin_account.officer = current_user
    @admin_account.creator = current_user

    respond_to do |format|
      if @admin_account.save
        format.html { redirect_to [:admin, @admin_account], notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @admin_account }
      else
        format.html { render :new }
        format.json { render json: @admin_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/accounts/1
  # PATCH/PUT /admin/accounts/1.json
  def update
    respond_to do |format|
      if @admin_account.update(admin_account_params)
        format.html { redirect_to [:admin, @admin_account], notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_account }
      else
        format.html { render :edit }
        format.json { render json: @admin_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/accounts/1
  # DELETE /admin/accounts/1.json
  def destroy
    @admin_account.destroy
    respond_to do |format|
      format.html { redirect_to admin_accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_account
    @admin_account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_account_params
    params.require(:account).permit(:title, :amount, :is_public)
  end
end
