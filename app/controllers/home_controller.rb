class HomeController < ApplicationController
  layout 'application'

  def index
    p request.subdomains
  end

  def page_index

  end

  def login
  end

  def register

  end

  def sign_up
    @user = User.new(params.require(:user).permit!)
    respond_to do |format|
      if @user.save
        format.html { redirect_to home_login_path, notice: 'Registration was successfully .' }
      else
        @errors = @user.errors.as_json
        p @user.errors
        format.html { render :register }
      end
    end
  end
end
