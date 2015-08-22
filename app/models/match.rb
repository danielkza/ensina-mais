class Match < ActiveRecord::Base
  belongs_to :region
  belongs_to :user
  belongs_to :sport

  has_and_belongs_to_many :joined_users, class_name: 'User', join_table: 'match_joined_users'

  acts_as_mappable default_units: :kms, default_formula: :flat
end
