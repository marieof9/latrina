class LatrinasChannel < ApplicationCable::Channel
  def subscribed
    lock = Lock.find_by name: params['name']
    stop_all_streams
    stream_for lock
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
