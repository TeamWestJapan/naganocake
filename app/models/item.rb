class Item < ApplicationRecord
    validates: name, presence: true
    validates: introduction, presence: true
    validates: price, presence: true
end
