require 'rails_helper'

RSpec.describe 'LatrinasRouting', type: :routing do

  describe 'GET /' do
    it 'routes to #index' do
      expect(:get => '/').to route_to(
        controller: 'latrinas',
        action: 'index'
        )
    end
  end

  describe 'GET /yolo' do
    it 'routes to #show' do
      expect(:get => '/yolo').to route_to(
        controller: 'latrinas',
        action: 'show',
        id: 'yolo'
        )
    end
  end

  describe 'LOCK /yolo' do
    it 'routes to #show' do
      expect(:lock => '/yolo').to route_to(
        controller: 'latrinas',
        action: 'lock',
        id: 'yolo'
        )
    end
  end

  describe 'UNLOCK /yolo' do
    it 'routes to #show' do
      expect(:unlock => '/yolo').to route_to(
        controller: 'latrinas',
        action: 'unlock',
        id: 'yolo'
        )
    end
  end
end
