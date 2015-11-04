class User < ActiveRecord::Base
 before_save :set_default_access
 # Include default devise modules. Others available are:
 # :confirmable, :lockable, :timeoutable and :omniauthable
 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

 has_many :devices, dependent: :destroy
 accepts_nested_attributes_for :devices, allow_destroy: true

 def set_default_access
  default_level = 2
  self.role_id = (Role.find_by access_level: default_level).id if self.role_id.nil?
  end
end
