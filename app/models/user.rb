class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :invoices, dependent: :destroy

  def role?(r)
  	role.include? r.to_s
  end
end
