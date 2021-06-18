require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'Model relations' do
    it { is_expected.to have_many(:reservations) }
  end

  describe 'Model validations' do
    subject { described_class.new(email: 'test@example.com') }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
