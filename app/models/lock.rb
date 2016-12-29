class Lock < ApplicationRecord
  def lock
    self[:locked] = true
  end

  def unlock
    self[:locked] = false
  end
end
