class Lock < ApplicationRecord
  def lock
    self[:locked] = true
  end

  def unlock
    self[:locked] = false
  end

  after_save do
    LatrinasChannel.broadcast_to self,
      locked: locked?
  end
end
