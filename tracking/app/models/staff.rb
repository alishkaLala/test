class Staff < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation, :name
  
  has_secure_password
  has_many :tickets
  has_many :comments
    
  validates :login, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, :confirmation => true, :confirmation => true,  length: {minimum: 1 }
  validates :login, :exclusion => { :in => %w(admin), :on => :create  }
  
end
