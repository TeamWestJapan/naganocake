class Order < ApplicationRecord
    validates :postal_code, presence: true
    validates :address, presence: true
    validates :name, presence: true
    validates :shipping_cost, presence: true
    validates :total_payment, presence: true
    validates :payment_method, presence: true
    validates :status, presence: true
    belongs_to :customer
    has_many :order_details, dependent: :destroy
end
