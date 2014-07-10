class Admin::AccountDetailsController < Admin::BaseController
  add_breadcrumb :controller, action: :index
  before_action :set_admin_account_detail, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_account

  # GET /admin/account_details
  # GET /admin/account_details.json
  def index
    add_breadcrumb :index, :index
    @admin_account_details = AccountDetail.where(:account => @admin_account)
    @last_details = []
    @last_amounts = []
    @admin_account.account_details.select(:sum, :amount).last(6).each do |i|
      @last_details << i.sum
      @last_amounts << i.amount
    end

  end

  # GET /admin/account_details/1
  # GET /admin/account_details/1.json
  def show
    add_breadcrumb :show, :show
  end

  # GET /admin/account_details/new
  def new
    add_breadcrumb :new, :new
    @admin_account_detail = AccountDetail.new
  end

  # GET /admin/account_details/1/edit
  def edit
    add_breadcrumb :new, :new
  end

  # POST /admin/account_details
  # POST /admin/account_details.json
  def create
    AccountDetail.transaction do
      @admin_account_detail = AccountDetail.new(admin_account_detail_params)
      @admin_account_detail.user = current_user
      @admin_account_detail.account = @admin_account
      @admin_account.amount += @admin_account_detail.sum
      @admin_account_detail.amount = @admin_account.amount
      respond_to do |format|
        if @admin_account_detail.save && @admin_account.save
          format.html { redirect_to admin_account_account_details_path, notice: 'Account detail was successfully created.' }
          format.json { render :show, status: :created, location: @admin_account_detail }
        else
          format.html { render :new }
          format.json { render json: @admin_account_detail.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /admin/account_details/1
  # PATCH/PUT /admin/account_details/1.json
  def update
    respond_to do |format|
      if @admin_account_detail.update(admin_account_detail_params)
        format.html { redirect_to admin_account_account_details_path, notice: 'Account detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_account_detail }
      else
        format.html { render :edit }
        format.json { render json: @admin_account_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/account_details/1
  # DELETE /admin/account_details/1.json
  def destroy
    @admin_account_detail.destroy
    respond_to do |format|
      format.html { redirect_to admin_account_account_details_path, notice: 'Account detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_account_detail
    @admin_account_detail = AccountDetail.find(params[:id])
  end

  def set_admin_account
    @admin_account = Account.find(params[:account_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_account_detail_params
    params.require(:account_detail).permit(:title, :sum, :type, :user_id, :memo, :purpose, :account_id)
  end
end
