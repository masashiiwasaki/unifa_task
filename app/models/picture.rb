class Picture < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validate :image_presence

  scope :created_order, (-> { order(created_at: :desc) })

  private

  def image_presence
    if !image.attached?
      errors.add(:image, :no_image)
    end
  end
end
