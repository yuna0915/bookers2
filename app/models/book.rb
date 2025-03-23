class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def clean
    errors.add(:title, "can't be blank") if title.blank?
    errors.add(:body, "can't be blank") if body.blank?
  end
end


