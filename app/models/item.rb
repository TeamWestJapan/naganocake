class Item < ApplicationRecord
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true

    validates :is_active, inclusion: [true,false]

    has_many :cart_items, dependent: :destroy
    has_many :order_details, dependent: :destroy
    belongs_to :genre
    has_one_attached :image
end
