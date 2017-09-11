class Node < ActiveRecord::Base

  # Define constants
  TITLE_LENGTH_MAX = 255
  TEXT_LENGTH_MAX = 1024

  # validations
  validates :title, presence: true, length: {maximum: TITLE_LENGTH_MAX}
  validates :text, length: {maximum: TEXT_LENGTH_MAX}

end
