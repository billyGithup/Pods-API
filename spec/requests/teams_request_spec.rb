require 'rails_helper'

RSpec.describe "Teams", type: :request do
  # Tests for GET requests.
  describe '#index' do
    let!(:teams) {create_list :team, 2}

    before {get '/teams'}

    it 'should return a teams list' do
      expect(json).not_to be_empty
    end
  end
end