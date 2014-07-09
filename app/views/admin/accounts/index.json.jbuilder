json.array!(@admin_accounts) do |admin_account|
  json.extract! admin_account, :id, :title, :amount, :is_public
  json.url admin_account_url(admin_account, format: :json)
end
