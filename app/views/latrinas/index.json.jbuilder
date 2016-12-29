json.array!(@locks) do |lock|
  json.name lock.name
  json.locked lock.locked?
  json.since lock.updated_at
end
