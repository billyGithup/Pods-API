require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'validations' do
    it {should belong_to(:employee)}

    it {should belong_to(:team)}
  end
end
