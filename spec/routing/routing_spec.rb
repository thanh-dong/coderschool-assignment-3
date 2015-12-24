require 'rails_helper'

RSpec.describe 'routing to signup', :type => :routing do
  it 'routes /sign_up to user#new' do
    expect(:get => '/sign_up').to route_to(
                                      :controller => 'users',
                                      :action => 'new'
                                  )
  end
end

RSpec.describe 'routing to sign_in', :type => :routing do
  it 'routes /sign_in to session#new' do
    expect(:get => '/sign_in').to route_to(
                                      :controller => 'sessions',
                                      :action => 'new'
                                  )
  end
end

RSpec.describe 'routing to authenticate', :type => :routing do
  it 'routes /authenticate to session#create' do
    expect(:post => '/authenticate').to route_to(
                                      :controller => 'sessions',
                                      :action => 'create'
                                  )
  end
end