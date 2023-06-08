require 'rails_helper'

RSpec.describe Payment, type: :model do
  before do
    @user = User.create!(name: "Marco", email: Faker::Internet.email, password: "123456")
    @user.confirm

  end

  it 'is valid with correct parameters' do
    payment = Payment.create!(name: 'Barbie Doll', amount: 113.5, author: @user)
    expect(payment).to be_valid
  end

  it 'is invalid without an author' do
    payment = Payment.new(name: 'Barbie Doll', amount: 113.5)
    expect(payment).to_not be_valid
  end

  describe 'associations' do
    it 'should have many categories through payment_categories' do
      payment = Payment.reflect_on_association(:categories)
      expect(payment.macro).to eq(:has_many)
      expect(payment.through_reflection.name).to eq(:payment_categories)
    end

    it 'should have many payment_categories' do
      payment = Payment.reflect_on_association(:payment_categories)
      expect(payment.macro).to eq(:has_many)
    end
  end
end
