require 'rails_helper'

RSpec.describe PaymentCategory, type: :model do
  before do
    @user = User.create!(name: "Marco", email: Faker::Internet.email, password: "123456")
    @user.confirm
    @payment = Payment.create!(name: 'Barbie Doll', amount: 113.5, author: @user)
    @category = Category.create!(name: 'Home', icon: "icon1.jpg", author: @user)

  end
  it 'is valid with correct parameters' do
    payment_categories = PaymentCategory.create!(category: @category, payment: @payment)
    expect(payment_categories).to be_valid
  end

  it 'is invalid without an category' do
    payment_categories = PaymentCategory.new(payment: @payment)
    expect(payment_categories).to_not be_valid
  end
end

