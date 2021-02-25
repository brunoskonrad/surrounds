require 'rails_helper'

RSpec.describe SearchMomentsAroundPoint do
  before do
    # TODO find meaningful locations to test
    create(:moment, position: spec_point(2, 2.00001))
    create(:moment, position: spec_point(3, 2.00001))
    create(:moment, position: spec_point(2.00004, 2.00001))
  end

  subject {
    described_class.call(point)
  }

  context "when on a very far point" do
    let(:point) { spec_point(6, 6) }

    it "returns no moment" do
      expect(subject.count).to eq(0)
    end
  end

  context "when in a nearby area" do
    let(:point) { spec_point(2, 2) }

    it "returns 2 moments" do
      expect(subject.count).to eq(2)
    end
  end
end
