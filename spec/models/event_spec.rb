require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'validate the presence of extended_html_description' do
    category = Category.create(id: 1)
    venue = Venue.create(id: 1)
    event = Event.new(name: 'event name', starts_at: DateTime.current, ends_at: DateTime.current, category: category, venue: venue, published: false)
    event.save
    error_message = "Extended html description can't be blank"
    expect(event.errors.full_messages).to include error_message
  end

  it 'validate the presence of value_id' do
    category = Category.create(id: 1)
    event = Event.new(name: 'event name', starts_at: DateTime.current, ends_at: DateTime.current, category: category, published: false, extended_html_description: 'content')
    event.save
    error_message = "Venue can't be blank"
    expect(event.errors.full_messages).to include error_message
  end

  it 'validate the presence of extended_html_description' do
    venue = Venue.create(id: 1)
    event = Event.new(name: 'event name', starts_at: DateTime.current, ends_at: DateTime.current, extended_html_description: 'content', venue: venue, published: false)
    event.save
    error_message = "Category can't be blank"
    expect(event.errors.full_messages).to include error_message
  end

  it 'validate start date should less than end date' do
    category = Category.create!(id: 1, name: 'Entertainment')
    venue = Venue.create!(id: 1)
    event = Event.new(name: 'event', starts_at: DateTime.current, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event.save
    error_message = "Starts at must be before end time"
    expect(event.errors.full_messages).to include error_message
  end

  describe '#search' do
    it 'should return all active events' do
      category = Category.create!(id: 1, name: 'Entertainment')
      venue = Venue.create!(id: 1)
      event_1 = Event.create!(name: 'Pool party event', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_2 = Event.create!(name: 'Charity event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_3 = Event.create!(name: 'Xmas', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_4 = Event.create!(name: 'Social event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      expect(Event.search(nil)).to match_array([event_2, event_4])
    end

    it 'should return active events which name matchs charity' do
      category = Category.create!(id: 1, name: 'Entertainment')
      venue = Venue.create!(id: 1)
      event_1 = Event.create!(name: 'Pool party event', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_2 = Event.create!(name: 'Charity event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_3 = Event.create!(name: 'Xmas', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_4 = Event.create!(name: 'Social event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      expect(Event.search('Charity')).to match_array([event_2])
    end

    it 'should return no events' do
      category = Category.create!(id: 1, name: 'Entertainment')
      venue = Venue.create!(id: 1)
      event_1 = Event.create!(name: 'Pool party event', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_2 = Event.create!(name: 'Charity event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_3 = Event.create!(name: 'Xmas', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: false, extended_html_description: 'content')
      event_4 = Event.create!(name: 'Social event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
      expect(Event.search('Xmas').count).to eq(0)
    end
  end
end
