class OrderDetail < ApplicationRecord
    validates :price, presence: true
    validates :amount, presence: true
    validates :making_status, presence: true
    belongs_to :order
    belongs_to :item

    enum making_status: {cannot_produce: 0, waiting_for_production: 1, in_production: 2, produced: 3}
end
