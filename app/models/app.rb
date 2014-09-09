class App < ActiveRecord::Base
  validates :name, presence: true
  validates :permission_level, presence: true

  def self.authorize!(a_k, s_k)
    app = App.find_by_access_key(a_k)
    app && App.find_by_access_key(a_k).secret_key == s_k
  end

end
