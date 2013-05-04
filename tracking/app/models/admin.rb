class Admin < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation, :name
  
  has_secure_password
      
  validates :login, presence: true, uniqueness: true
  validates :password, :confirmation => true,  length: {minimum: 1 }
end
