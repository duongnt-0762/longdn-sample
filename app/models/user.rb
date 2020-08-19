class User < ApplicationRecord
    attr_accessor :remember_token
    before_save :downcase_email
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validates :diachi, presence: true
    validates :gioitinh, presence: true
    validates :ngaysinh, presence: true	
    validate :check_date
    def remember
      self.remember_token = User.new_token
      update_attributes remember_digest: User.digest(remember_token)
    end
    # Forgets a user.
    def forget
      update_attributes remember_digest: nil
    end
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    class << self 
      def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
      def new_token
        SecureRandom.urlsafe_base64
      end  
    end
    def current_user?(user)
      user && user == self
    end
    private
    def check_date
      if ngaysinh.present? && ngaysinh >= Date.current
        errors.add(:ngaysinh, 'error dmm')
      end	
    end  
    def downcase_email
      self.email = email.downcase
    end
end