class Invoice < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :charge_amount, presence: true, numericality: {only_integer: true}
	serialize :invoice_items
	belongs_to :user
	validates_associated :user
end
