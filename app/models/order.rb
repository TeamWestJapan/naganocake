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
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum status: { waiting_for_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipping: 3, shipping: 4 }
end
