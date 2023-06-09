require 'rails_helper'

RSpec.describe '/payments', type: :request do
  before do
    @user = User.create!(name: 'Marco', email: Faker::Internet.email, password: '123456')
    @user.confirm
    sign_in @user

  end

  let(:valid_attributes) {
    {
      name: 'toys',
      amount: nil,
      author: @user
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      amount: nil,
      author: @user
    }
  }

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_payment_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      payment = Payment.create! valid_attributes
      get edit_payment_url(payment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Payment' do
        expect {
          post payments_url, params: { payment: valid_attributes }
        }.to change(Payment, :count).by(1)
      end

      it 'redirects to the created payment' do
        post payments_url, params: { payment: valid_attributes }
        expect(response).to redirect_to(payment_url(Payment.last))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested payment' do
      payment = Payment.create! valid_attributes
      expect {
        delete payment_url(payment)
      }.to change(Payment, :count).by(-1)
    end

    it 'redirects to the payments list' do
      payment = Payment.create! valid_attributes
      delete payment_url(payment)
      expect(response).to redirect_to(payments_url)
    end
  end
end
