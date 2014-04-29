module OauthSignupable
  extend ActiveSupport::Concern

  def self.extended(base)
    super
    base.class.before_validation :skip_confirmation!
  end

  protected
  def password_required?
    false
  end

  def email_required?
    false
  end

  module ClassMethods
  end
end
