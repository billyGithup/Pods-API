require 'rails_helper'

RSpec.describe 'employees', type: :routing do
  describe 'employees routes' do
    it 'should route to employees index' do
      expect(get '/employees').to route_to('employees#index')
    end

    it 'should route to employees show' do
      expect(get '/employees/1').to route_to('employees#show', id: '1')
    end

    it 'should route to employees create' do
      expect(post '/employees').to route_to('employees#create')
    end

    it 'should route to employees update' do
      expect(put '/employees/1').to route_to('employees#update', id: '1')
      expect(patch '/employees/1').to route_to('employees#update', id: '1')
    end

    it 'should route to employees destroy' do
      expect(delete '/employees/1').to route_to('employees#destroy', id: '1')
    end
  end
end
