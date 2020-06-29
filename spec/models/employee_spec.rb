require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    let!(:employee) {create :employee}

    it { should have_many(:memberships).dependent(:destroy) }

    it { should have_many(:teams).dependent(:destroy) }

    it {should validate_presence_of(:first_name)}

    it {should validate_presence_of(:last_name)}

    it {should validate_presence_of(:email)}

    it 'should not be nil when instantiated' do
      expect(described_class.new).not_to be_nil
    end

    context 'valid email' do
      it 'should have a valid email' do
        expect(employee.email).to match(URI::MailTo::EMAIL_REGEXP)
      end
    end

    context 'invalid email' do
      it 'should be invalid' do
        employee.email = '@example.com'
        expect(employee.email).not_to match(URI::MailTo::EMAIL_REGEXP)
      end
    end

    context 'valid name' do
      it 'should have a valid first name' do
        expect(employee.first_name).to match(/^[[:alpha:]\.\'[:blank:]]+$/)
      end

      it 'should have a valid last name' do
        expect(employee.last_name).to match(/^[[:alpha:]\.\'[:blank:]]+$/)
      end
    end

    context 'invalid name' do
      it 'should have a valid first name' do
        employee.first_name = 'first-name-1'
        expect(employee.first_name).not_to match(/^[[:alpha:]\.\'[:blank:]]+$/)
      end

      it 'should have a valid last name' do
        employee.last_name = 'last-name-1'
        expect(employee.last_name).not_to match(/^[[:alpha:]\.\'[:blank:]]+$/)
      end
    end
  end
end
