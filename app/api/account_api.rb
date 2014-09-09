class AccountApi < Grape::API
  helpers BasicAPI::GeneralHelpers

  before do
    @account = Account.find(params[:id].to_i) if params[:id]
    @user = User.find(params[:user_id].to_i) if params[:user_id]
  end

  resources :accounts do
    desc '获取公开账目和自己创建的账目'
    params do
      requires :user_id, type: Integer
      use :pagination
    end
    get 'user/:user_id' do
      pagination! Account.where('is_public = ? OR officer = ?', true, params[:user_id])
    end

    desc '添加账目'
    params do
      requires :account do
        requires :title, type: String
        requires :amount, type: Float, default: 0.0
        requires :creator, type: Integer
        requires :officer, type: Integer
        requires :is_public, type: Boolean, default: false
      end
    end
    post do
      account= Account.new params[:account]
      account.save
    end

    desc '对某账目进行操作'
    params do
      requires :id, type: Integer
    end
    namespace ':id' do
      desc '按id获取账目'
      get do
        @account
      end

      desc '修改账目'
      params do
        requires :title, type: String
      end
      put do
        @account.update_attributes title: params[:title]
      end

      desc '账目详细的操作'
      namespace 'details' do
        desc '获取某账目的详细记录'
        params do
          use :pagination
        end
        get do
          pagination! @account.account_details
        end

        desc '获取单个账目详细'
        params do
          requires :detail_id, type: Integer
        end
        get ':detail_id' do
          @account.account_details.find(params[:detail_id])
        end

        desc '添加账目详细'
        params do
          requires :title, type: String
          requires :sum, type: Float
          requires :memo, type: String
          requires :purpose, type: String
          requires :user_id, type: Integer
        end
        post do
          AccountDetail.transaction do
            account_detail = AccountDetail.new(admin_account_detail_params)
            account_detail.user = @user
            account_detail.account_id = params[:id]
            @account.amount += account_detail.sum
            account_detail.amount = @account.amount
            account_detail.save
          end
        end
      end
    end
  end
end



