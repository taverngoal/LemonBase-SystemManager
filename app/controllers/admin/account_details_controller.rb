class Admin::AccountDetailsController < Admin::BaseController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  before_action do
    add_breadcrumb I18n.t('breadcrumbs.admin.accounts.controller'), admin_accounts_path #
  end
  before_action :set_admin_account_detail, only: [:show, :edit, :update, :destroy] #
  before_action :set_admin_account

  # GET /admin/account_details
  # GET /admin/account_details.json
  def index

    @admin_account_details = initialize_grid(AccountDetail.where(:account => @admin_account).order('created_at DESC'), per_page: 20)
    @last_details = [] # sum的集合
    @last_amounts = [] # 金额变化集合
    @last_records = [] # 最后的记录，时间集合
    @admin_account.account_details.select(:sum, :amount, :created_at).last(10).each do |i|
      @last_details << i.sum
      @last_amounts << i.amount
      @last_records << i.created_at.strftime('%m月%d日 %H:%M')
    end
    authorize! :read, @admin_account

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

    authorize! :update, @admin_account
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
    add_breadcrumb @admin_account.title, action: :index #
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_account_detail_params
    params.require(:account_detail).permit(:title, :sum, :type, :user_id, :memo, :purpose, :account_id)
  end
end
