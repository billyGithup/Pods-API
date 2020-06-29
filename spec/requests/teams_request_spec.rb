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
        expect(json['message']).to include("Couldn't find Team")
      end
    end
  end

  describe '#list_employees' do
    before do
      team = teams.first
      employee = Employee.create(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email
      )
      team.memberships.create(employee: employee)
    end

    context 'the team id exists' do
      before {get "/teams/#{team_id}/list_employees"}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return a teams list' do
        expect(json).not_to be_empty
      end
    end

    context 'the team id does not exist' do
      before {get "/teams/#{team_id + 100}/list_employees"}

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should match the error message' do
        expect(json['message']).to include("Couldn't find Team")
      end
    end
  end

  # Tests for POST requests.
  describe '#create' do
    let(:valid_attrs) {{name: 'valid', lead: 'valid', active: true}}
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
        expect(json['message']).to include("can't be blank", 'is invalid')
      end
    end
  end

  describe '#add_employee' do
    let!(:team) {create :team}

    context 'invalid team ID' do
      before {post "/teams/#{team_id + 100}/add_employee", params: {}}

      it 'should return a not found message' do
        expect(json['message']).to include("Couldn't find Team")
      end
    end

    context 'valid employee attrs' do
      let(:valid_attrs) do
        {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email
        }
      end
      before {post "/teams/#{team_id}/add_employee", params: {employee: valid_attrs}}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should add an employee to a team' do
        expect(response.body).not_to be_empty
      end
    end

    context 'invalid employee attrs' do
      let(:invalid_attrs) do
        {
            first_name: '',
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email
        }
      end
      before {post "/teams/#{team_id}/add_employee", params: {employee: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to include("First name can't be blank", 'First name is invalid')
      end
    end
  end

  # Tests for PUT/PATCH requests.
  describe '#update' do
    let(:valid_attrs) {{active: true}}
    let(:invalid_attrs) {{lead: '????'}}

    context 'valid attrs' do
      before {put "/teams/#{team_id}", params: {team: valid_attrs}}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have a new lead name' do
        expect(json['active']).to eq(true)
      end
    end

    context 'invalid attrs' do
      before {patch "/teams/#{team_id}", params: {team: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to include('Lead is invalid')
      end
    end

    context "record doesn't exist" do
      before {put "/teams/#{team_id + 100}", params: {team: valid_attrs}}

      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should return a not found message' do
        expect(json['message']).to include("Couldn't find Team")
      end
    end
  end

  # Tests for DELETE requests.
  describe '#destroy' do
    context 'valid id' do
      before {delete "/teams/#{team_id}"}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'invalid id' do
      before {delete "/teams/#{team_id + 100}"}

      it 'should return a not found message' do
        expect(json['message']).to include("Couldn't find Team")
      end
    end
  end
end