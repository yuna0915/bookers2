class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: { message: "can't be blank" }
  validates :body, presence: { message: "can't be blank" }

end
