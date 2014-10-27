require 'base64'
class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :email, format: {with: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/, :multiline => true, message: '邮件格式不对'}

  has_many :created_accounts, class_name: 'Account', foreign_key: :creator
  has_many :managed_accounts, class_name: 'Account', foreign_key: :officer

  def available_accounts
    Account.where('is_public = ? OR officer = ?', true, self.id)
  end

  def self.auth_with_basic authcode
    username, psd = Base64.decode64(authcode).split(':')
    User.authenticate(username, psd)
  end


end
