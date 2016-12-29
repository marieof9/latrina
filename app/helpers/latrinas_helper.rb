module LatrinasHelper

  def lock_path(lock)
      "/#{lock.name}"
  end
end
