class OrderDetail < ApplicationRecord
    validates: price, presence: true
    validates: amount, presence: true
    validates: is_status, presence: true
end
