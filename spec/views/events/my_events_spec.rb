require 'rails_helper'

RSpec.describe 'events/my_events', :type => :view do
  it 'renders table of events' do
    category = Category.create!(id: 1, name: 'Entertainment')
    venue = Venue.create!(id: 1)
    event_1 = Event.create!(name: 'Pool party event', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_2 = Event.create!(name: 'Charity event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_3 = Event.create!(name: 'Xmas', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_4 = Event.create!(name: 'Social event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    assign(:events, [event_1, event_2, event_3, event_4])
    render

    expect(rendered).to include('Pool party event')
    expect(rendered).to include('Charity event')
    expect(rendered).to include('Xmas')
    expect(rendered).to include('Social event')
  end

  it 'renders message when there is no event' do
    assign(:events, [])
    render
    expect(rendered).to include('You did not create any event')
  end
end