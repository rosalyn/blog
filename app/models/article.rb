class Article < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true,
                    length: { minimum: 5 }

  #accepts_nested_attributes_for :taggings, :allow_destroy => :true,
  #                              :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  	self.tags = new_or_found_tags
  end
end
