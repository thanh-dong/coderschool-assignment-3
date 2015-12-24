class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  validate :start_must_be_before_end_time

  def self.search(keyword)
    if keyword
      where('? <= ends_at AND name LIKE ?', DateTime.current, "%#{keyword}%")
    else
      where('? <= ends_at', DateTime.current)
    end
  end

  private

  def start_must_be_before_end_time
    errors.add(:starts_at, "must be before end time") unless
        starts_at <= ends_at
  end
end
