class CartItem < ApplicationRecord
    validates: amount, presence: true
end
