class Order < ApplicationRecord
    validates :postal_code, presence: true
    validates :address, presence: true
    validates :name, presence: true
    belongs_to :customer
    has_many :order_details, dependent: :destroy
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum status: { waiting_for_payment: 0, payment_confirm: 1, in_production: 2, preparing_for_shipping: 3, shipping: 4 }

    after_update :update_order_details_making_status, if: :saved_change_to_status?
    #after_update :update_order_status, if: :saved_change_to_making_status?

    def address_display
      '〒' + postal_code + ' ' + address + ' ' + name
    end

    private

    def update_order_details_making_status
      if self.status == "payment_confirm"
        order_details.update_all(making_status: OrderDetail.making_statuses_i18n[:wating_for_production])
      end
    end

    def update_order_status
      if self.making_status == "in_production"
        self.update(status: "in_production")
      end
    end
end

