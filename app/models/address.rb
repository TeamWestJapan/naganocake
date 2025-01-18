class Address < ApplicationRecord
    validates :address, presence: true
    validates :name, presence: true
    belongs_to :customer

    def address_display
      '〒' + postal_code + ' ' + address + ' ' + name
    end

end
