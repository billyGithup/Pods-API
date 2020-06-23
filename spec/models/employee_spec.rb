require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it { should have_many(:memberships).dependent(:destroy) }

    it {should validate_presence_of(:first_name)}

    it {should validate_presence_of(:last_name)}

    it {should validate_presence_of(:email)}

    it 'should not be nil when instantiated' do
      expect(Employee.new).not_to be_nil
    end
  end
end
