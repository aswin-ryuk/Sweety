class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  validates :role, presence: true

  has_many :reports

  ROLES=[['Patient', 'patient']]


  def patient?
  	self.role == 'patient'
  end

end
