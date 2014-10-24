class UserApi < Grape::API
  helpers BasicAPI::GeneralHelpers


  resource :users do
    before do
      @user = User.find params[:id] if params[:id]
    end
    desc '获取所有用户列表'
    params do
      use :pagination
    end
    get do
      users = pagination! User.all().select(:email, :name, :nick, :birth, :address, :phone, :id)
      authenticate! :read, users
    end

    desc '创建用户'
    params do
      requires :email, type: String, regexp: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
      requires :password, type: String
      optional :name, type: String
      optional :nick, type: String
      optional :birth, type: Date
      optional :address, type: String
      optional :phone, type: String
    end
    post do
      authenticate! :create, User
      user = User.new email: params[:email], password: params[:password], password_confirmation: params[:password],
                      name: params[:name], nick: params[:nick], birth: params[:birth],
                      address: params[:address], phone: params[:phone]
      (user.errors unless user.save) || user
    end

    params do
      requires :id, type: Integer
    end
    namespace ':id' do

      desc '获取某个用户'
      get do
        @user
        authenticate! @user
      end

      desc '删除某个用户'
      delete do
        authenticate! :destroy, @user
        @user.errors unless @user.destroy
      end


      desc '修改某个用户'
      params do
        requires :email, type: String, regexp: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
        optional :password, type: String
        optional :name, type: String
        optional :nick, type: String
        optional :birth, type: Date
        optional :address, type: String
        optional :phone, type: String
      end
      put do
        authenticate! :update, @user
        @user.update_attributes email: params[:email],
                                name: params[:name], nick: params[:nick], birth: params[:birth],
                                address: params[:address], phone: params[:phone]
        unless @user.save
          @user.errors
        end
      end
    end
  end
end