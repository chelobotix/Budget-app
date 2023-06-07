class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :payment_categories, dependent: :destroy
  has_many :payments, through: :payment_categories

  def total_amount_category
    payments.sum(:amount)
  end
end
