require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let!(:employees) {create_list(:employee, 2)}
  let(:employee_id) {employees.first.id}

  # Tests for GET requests.
  describe '#index' do
    before {get '/employees'}

    it 'should return an employee list' do
      expect(json).not_to be_empty
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    context 'the id-specified employee exists in the employees table' do
      before {get "/employees/#{employee_id}"}

      it 'should return the specified employee' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(employee_id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'the id-specified employee is not found' do
      before {get "/employees/#{employee_id + 100}"}

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
    let(:valid_attrs) {{first_name: 'valid', last_name: 'valid', email: 'example@example.com'}}
    let(:invalid_attrs) {{first_name: '', last_name: 'invalid1', email: '@example.com'}}

    context 'valid attrs' do
      before {post '/employees', params: {employee: valid_attrs}}

      it 'should return a new team with the lead as Bob' do
        expect(json['first_name']).to eq('valid')
      end

      it 'should return status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'invalid attrs' do
      before {post '/employees', params: {employee: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to match('Name only allow letters, spaces, apostrophe, and dots. Email only allows example@example.com format.')
      end
    end
  end

  # Tests for PUT/PATCH requests.
  describe '#update' do
    let(:valid_attrs) {{first_name: 'New name'}}
    let(:invalid_attrs) {{first_name: '????'}}

    context 'valid attrs' do
      before {put "/employees/#{employee_id}", params: {employee: valid_attrs}}

      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should have a new lead name' do
        expect(json['first_name']).to eq('New name')
      end
    end

    context 'invalid attrs' do
      before {patch "/employees/#{employee_id}", params: {employee: invalid_attrs}}

      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should have a message body' do
        expect(json['message']).to match('Name only allow letters, spaces, apostrophe, and dots. Email only allows example@example.com format.')
      end
    end

    context "record doesn't exist" do
      before {put "/employees/#{employee_id + 100}", params: {team: valid_attrs}}

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
    before {delete "/employees/#{employee_id}"}

    it 'should return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
