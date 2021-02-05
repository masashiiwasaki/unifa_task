class LoginUser
  include ActiveModel::Model

  attr_accessor :uid, :password

  validates :uid, presence: true
  validates :password, presence: true
  # validate  :true_uid
  validate  :true_uid_password

  # def true_uid
  #   errors.add(:uid, "は使われていません。") unless User.find_by(uid: uid)
  # end

  def true_uid_password
    return if uid.blank? || password.blank?

    @user = User.find_by(uid: uid)
    if @user
        errors.add(:password, :no_match) unless @user.authenticate(password)
    else
        errors.add(:uid, :no_match)
    end
  end

  def save
    return false if invalid?
    true
  end
end
