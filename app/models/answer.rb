class Answer < ActiveRecord::Base
  belongs_to :question
  validates :body, presence: true

  scope :existing, -> { where.not(id: nil) }
end
