class User < ApplicationRecord
  has_many :categories, foreign_key: :author_id, dependent: :destroy
  has_many :payments, foreign_key: :author_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
