class Pin < ActiveRecord::Base
  acts_as_taggable_on :tags
  acts_as_taggable
  acts_as_votable
  belongs_to :user
  searchkick

  has_attached_file :image, styles: { :medium => "300x300>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
