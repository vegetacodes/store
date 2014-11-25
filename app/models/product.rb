class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  validates :description, :image_url, :title, presence: :true
  validates :price, numericality: { greater_than_or_equal_to: 0.01}
  
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be an url for gif, jpg or png image'
  }

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false
    end
  end
end
