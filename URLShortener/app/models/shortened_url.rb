# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string
#  long_url   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class ShortenedURL < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  def self.random_code
    shortened = SecureRandom.urlsafe_base64() # trust
    until !self.all.any? { |thing| thing.short_url == shortened }
      shortened = SecureRandom.urlsafe_base64() # trust
    end
    shortened
  end

  def self.make_url(user, input_url)
    # user.id
    output = ShortenedURL.random_code
    ShortenedURL.create({user_id: user.id, long_url: input_url, short_url: output})
    # new_url.create
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitors

  def num_clicks
  end

  def num_uniques
  end

  def num_recent_uniques
  end
end
