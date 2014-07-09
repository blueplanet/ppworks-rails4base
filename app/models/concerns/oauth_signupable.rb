module OauthSignupable
  extend ActiveSupport::Concern

  def self.extended(base)
    super
    base.class.before_validation do
      if respond_to?(:skip_confirmation!)
        skip_confirmation!
      end
    end
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
