require 'rails_helper'

RSpec.describe 'teams', type: :routing do
  describe 'teams routes' do
    it 'should route to teams index' do
      expect(get '/teams').to route_to('teams#index')
    end

    it 'should route to teams show' do
      expect(get '/teams/1').to route_to('teams#show', id: '1')
    end

    it 'should route to teams create' do
      expect(post '/teams').to route_to('teams#create')
    end

    it 'should route to teams update' do
      expect(put '/teams/1').to route_to('teams#update', id: '1')
      expect(patch '/teams/1').to route_to('teams#update', id: '1')
    end

    it 'should route to teams destroy' do
      expect(delete '/teams/1').to route_to('teams#destroy', id: '1')
    end

    it 'should route to list_employees' do
      expect(get '/teams/1/list_employees').to route_to('teams#list_employees', id: '1')
    end

    it 'should route to add_employee' do
      expect(post '/teams/1/add_employee').to route_to('teams#add_employee', id: '1')
    end
  end
end
