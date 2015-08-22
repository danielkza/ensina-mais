class LoginInfo
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :user_id, :application_id, :access_token

  def initialize(attrs={})
    attrs.each do |attr, val|
      send("#{attr}=", val)
    end
  end
end