class Address < ApplicationRecord
    validates: address, presence: true
    validates: name, presence: true
end
