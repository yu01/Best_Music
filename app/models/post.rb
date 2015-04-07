class Post < ActiveRecord::Base
  acts_as_votable

  scope :pagination, ->(page) { paginate(page: page, per_page: 2) }
  scope :tencet_index, -> { where(suit: false).order(:created_at) }
  scope :tencet_all, -> { where(suit: true).where("created_at < ?", Time.now).order('updated_at desc') }
end
