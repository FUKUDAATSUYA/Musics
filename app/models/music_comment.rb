class MusicComment < ApplicationRecord
  belongs_to :user
  belongs_to :music
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
end