class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all

  validates :title, :body, presence: true

  def saved_answers
    answers.existing
  end
end
