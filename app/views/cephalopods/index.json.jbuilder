json.array!(@cephalopods) do |cephalopod|
  json.extract! cephalopod, :id, :name, :tentacles
  json.url cephalopod_url(cephalopod, format: :json)
end
