require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    let!(:team) {create :team}

    it { should have_many(:memberships).dependent(:destroy) }

    it { should have_many(:employees).dependent(:destroy) }

    it {should validate_presence_of(:name)}

    it {should validate_presence_of(:lead)}

    it 'should not be nil when instantiated' do
      expect(team).not_to be_nil
    end

    context 'valid attrs' do
      it 'should match the active' do
        expect(team.active).to eq(false)
      end
    end
  end
end
