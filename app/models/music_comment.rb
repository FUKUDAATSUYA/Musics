class MusicComment < ApplicationRecord
  belongs_to :user
  belongs_to :music

  validates :content, presence: true
end