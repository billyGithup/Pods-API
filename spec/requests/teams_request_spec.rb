require 'rails_helper'

RSpec.describe "Teams", type: :request do
  let!(:teams) {create_list(:team, 2)}
  let(:team_id) {teams.first.id}

  # Tests for GET requests.
  describe '#index' do
    before {get '/teams'}

    it 'should return a teams list' do
      expect(json).not_to be_empty
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    context 'the id-specified team exists in the teams table' do
      before {get "/teams/#{team_id}"}

      it 'should return the specified team' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(team_id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'the id-specified team is not found' do
      before {get "/teams/#{team_id + 100}"}

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should return a not found message' do
        expect(json['message']).to match('Record is not found!')
      end
    end
  end

  # Tests for POST requests.
  describe '#create' do
    let(:valid_attrs) {{name: 'valid', lead: 'valid', active: 'No'}}
    let(:invalid_attrs) {{name: '', lead: 'invalid1', active: ''}}

    context 'valid attrs' do
      before {post '/teams', params: {team: valid_attrs}}

      it 'should return a new team with the lead as Bob' do
        expect(json['lead']).to eq('valid')
      end

      it 'should return status code 201' do
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'invalid attrs' do
      before {post '/teams', params: {team: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to match('Name and Lead only allow letters, spaces, apostrophe, and dots. Active only allows Yes or No.')
      end
    end
  end

  # Tests for PUT/PATCH requests.
  describe '#update' do
    let(:valid_attrs) {{lead: 'New leader'}}
    let(:invalid_attrs) {{lead: '????'}}

    context 'valid attrs' do
      before {put "/teams/#{team_id}", params: {team: valid_attrs}}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have a new lead name' do
        expect(json['lead']).to eq('New leader')
      end
    end

    context 'invalid attrs' do
      before {patch "/teams/#{team_id}", params: {team: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to match('Name and Lead only allow letters, spaces, apostrophe, and dots. Active only allows Yes or No.')
      end
    end

    context "record doesn't exist" do
      before {put "/teams/#{team_id + 100}", params: {team: valid_attrs}}

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should return a not found message' do
        expect(json['message']).to match('Record is not found!')
      end
    end
  end

  # Tests for DELETE requests.
  describe '' do
    before {delete "/teams/#{team_id}"}

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end