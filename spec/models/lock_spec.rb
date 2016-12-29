require 'rails_helper'

RSpec.describe Lock, type: :model do
  subject { build(:lock) }

  describe '.lock' do
    it 'ensures the lock is locked' do
      subject.lock
      expect(subject.locked?).to be true
    end
  end

  describe '.unlock' do
    it 'ensures the lock not locked' do
      subject.unlock
      expect(subject.locked?).to be false
    end
  end
end
