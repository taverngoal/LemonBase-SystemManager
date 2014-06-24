json.array!(@apps) do |app|
  json.extract! app, :id, :access_key, :secret_key, :permiss_level, :enable
  json.url app_url(app, format: :json)
end
