require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'Model relations' do
    it { is_expected.to belong_to(:guest) }
  end
end
