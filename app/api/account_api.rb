class AccountApi < Grape::API
  helpers BasicAPI::GeneralHelpers


  resources :accounts do
    before do
      @account = Account.find(params[:id].to_i) if params[:id]
    end
    desc '获取公开账目和自己创建的账目'
    params do
      use :pagination
    end
    get do
      accounts= pagination! Account.all.order('created_at DESC')
      authenticate! :read, accounts
      header 'total', Account.all.length.to_s
      accounts.as_json(include: [creator: {only: [:name]}, officer: {only: [:name]}])
    end

    desc '添加账目'
    params do
      requires :title, type: String
      requires :amount, type: Float, default: 0.0
      requires :is_public, type: Boolean, default: false
    end
    post do
      authenticate! :create, Account #判断账目创建权限
      account, account.creator, account.officer =
          Account.new(title: params[:title], amount: params[:amount], creator: @current_user, officer: @current_user,
                      is_public: params[:is_public]), @current_user, @current_user
      (account.errors unless account.save) || account
    end

    desc '对某账目进行操作'
    params do
      requires :id, type: Integer
    end
    namespace ':id' do
      desc '按id获取账目'
      get do
        @account
        authenticate! :show, @account
      end

      desc '修改账目'
      params do
        requires :title, type: String
        optional :is_public, type: Boolean
      end
      post do
        authenticate! :update, @account
        @account.update_attributes title: params[:title], is_public: params[:is_public]
        unless @account.save
          @account.errors
        end
      end

      desc '账目详细的操作'
      namespace 'details' do
        desc '获取某账目的详细记录'
        params do
          use :pagination
        end
        get do
          details = pagination! @account.account_details.order('created_at DESC')
          authenticate! :read, details
          header 'total', @account.account_details.length.to_s
          details.as_json(include: [:user => {only: [:name]}])
        end

        desc '获取单个账目详细'
        params do
          requires :detail_id, type: Integer
        end
        get ':detail_id' do
          detail= @account.account_details.find(params[:detail_id])
          authenticate! :read, detail
        end

        desc '添加账目详细'
        params do
          requires :title, type: String
          requires :sum, type: Float
          optional :memo, type: String
          optional :purpose, type: String
        end
        post do

          AccountDetail.transaction do
            account_detail, account_detail.user, account_detail.account_id, account_detail.amount =
                AccountDetail.new(title: params[:title], sum: params[:sum], memo: params[:memo], purpose: params[:purpose]),
                    @current_user, params[:id], @account.amount
            @account.amount += account_detail.sum
            account_detail.amount = @account.amount
            # account_detail.user = @current_user
            # account_detail.account_id = params[:id]
            # @account.amount += account_detail.sum
            authenticate! :create, account_detail
            @account.save
            (account_detail.errors unless account_detail.save) || account_detail
          end
        end
      end
    end
  end
end