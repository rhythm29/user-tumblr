class Post < ApplicationRecord
  validates :image, presence: true
  has_attached_file :image, styles: { :medium => "640x" }
  validates :username,presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def add_username(username)
    self.username = username
  end
end
