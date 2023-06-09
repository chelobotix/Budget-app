require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @user = User.create!(name: 'Marco', email: Faker::Internet.email, password: '123456')
  end

  it 'is valid with correct parameters' do
    category = Category.create!(name: 'Home', icon: 'icon1.jpg', author: @user)
    expect(category).to be_valid
  end

  it 'is invalid without an author' do
    category = Category.new(name: 'Home', icon: 'icon1.jpg')
    expect(category).to_not be_valid
  end

  describe 'associations' do
    it 'should have many payments through payment_categories' do
      category = Category.reflect_on_association(:payments)
      expect(category.macro).to eq(:has_many)
      expect(category.through_reflection.name).to eq(:payment_categories)
    end

    it 'should have many payment_categories' do
      category = Category.reflect_on_association(:payment_categories)
      expect(category.macro).to eq(:has_many)
    end
  end
end
