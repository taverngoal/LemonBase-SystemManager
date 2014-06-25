json.array!(@admin_apps) do |admin_app|
  json.extract! admin_app, :id, :name, :access_key, :secret_key, :permission_level, :enable
  json.url admin_app_url(admin_app, format: :json)
end
