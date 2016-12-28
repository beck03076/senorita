require 'rails_helper'

RSpec.describe 'Routes for search pages', type: :routing do
  it 'routes root page' do
    expect(get('/')).to route_to(controller: 'searches', action: 'index')
  end

  it 'routes search create' do
    expect(post('/searches')).to route_to(controller: 'searches',
                                          action: 'create')
  end
end
