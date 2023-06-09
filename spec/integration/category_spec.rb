require 'rails_helper'
require 'faker'
require 'cancan'

RSpec.describe 'Category#Index', type: :system do
  let(:user) do
    user = User.create!(name: 'Marco', email: Faker::Internet.email, password: '123456')
  end

  let(:category) do
    Category.create(name: 'Education', icon: 'icons.jpg', author: user)
  end

  let(:payment) do
    Payment.create(name: 'Barbie doll', amount: 56 , author: user)
  end

  let(:payment2) do
    Payment.create(name: 'Gi Joe', amount: 102.4 , author: user)
  end

  before do
    user.confirm
    sign_in user
  end

  describe 'index page' do
    it 'has the user categories' do
      Category.create(name: 'Education', icon: 'icons.jpg', author: user)
      visit categories_path
      expect(page).to have_content('Education')
    end

    it 'has button to create a new category' do
      visit categories_path
      expect(page).to have_link('Add a New Category')
    end
  end

  describe 'Categories#Show' do
    it 'has the Add a new transaction button' do
      visit category_path(category.id)
      expect(page).to have_content('Add a new transaction')
    end

    it 'has the payment Barbie doll' do
      PaymentCategory.create(payment: payment, category: category)
      visit category_path(category.id)
      expect(page).to have_content('Barbie doll')
      expect(page).to have_content('Total Payment 56.0 $us')

    end

    it 'has the total amount of the category' do
      PaymentCategory.create(payment: payment, category: category)
      PaymentCategory.create(payment: payment2, category: category)
      visit category_path(category.id)
      expect(page).to have_content('(158.4 $us)')
    end

    it 'has the Back to categories button' do
      visit category_path(category.id)
      expect(page).to have_content('<')
    end
  end

  describe 'Category#New' do
    before do
      visit new_category_path
    end

    it 'has the input fields' do
      expect(page).to have_field('Name')
      expect(page).to have_css('.img_icon')
    end
  end

  describe 'Category#Create' do
    before do
      visit new_category_path
    end

    it 'creates a new category' do
      fill_in 'Name', with: 'Health'
      choose('category_icon_img_icon1')
      click_button 'Save'

      expect(page).to have_content('Category was successfully created.')
    end
  end

  describe 'Payment create new' do
    before do
      visit payment_create_new_path(category.id)
    end

    it 'has the input fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Amount')
    end

    it 'Add new payment to category' do
      fill_in 'payment[name]', with: 'Micro machine car'
      fill_in 'payment[amount]', with: 23.5
      click_button 'Save'

      expect(page).to have_content('Transaction was successfully added.')
    end
  end

end
