require 'rails_helper'

RSpec.describe 'events/index', :type => :view do
  it 'renders _card partial for each event' do
    category = Category.create!(id: 1, name: 'Entertainment')
    venue = Venue.create!(id: 1)
    event_1 = Event.create!(name: 'Pool party event', starts_at: DateTime.current - 2.days, ends_at: DateTime.current - 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_2 = Event.create!(name: 'Charity event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_3 = Event.create!(name: 'Xmas', starts_at: DateTime.current - 3.days, ends_at: DateTime.current - 2.days, category: category, venue: venue, published: false, extended_html_description: 'content')
    event_4 = Event.create!(name: 'Social event', starts_at: DateTime.current - 1.day, ends_at: DateTime.current + 1.day, category: category, venue: venue, published: false, extended_html_description: 'content')
    assign(:events, [event_1, event_2, event_3, event_4])
    render
    expect(view).to render_template(:partial => '_card', :count => 4)
  end
end