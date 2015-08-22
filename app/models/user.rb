class User < ActiveRecord::Base
  has_many :matches
  has_and_belongs_to_many :joined_matches, class_name: 'Match', join_table: 'match_joined_users'

  before_create :set_auth_token!

  def self.gen_auth_token
    SecureRandom.uuid
  end

  def avatar
    "#{Koala::HTTPService.server}/#{facebook_id}/picture?width=300&height=300"
  end

  protected

  def set_auth_token!
    reset_auth_token! unless self.auth_token
  end

  def reset_auth_token!
    self.auth_token = self.class.gen_auth_token
  end
end
