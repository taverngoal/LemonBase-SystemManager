class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :email, format: {with: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/, :multiline => true, message: '邮件格式不对'}
end
