json.array!(@admin_account_details) do |admin_account_detail|
  json.extract! admin_account_detail, :id, :title, :sum, :type, :user_id, :memo, :purpose, :account_id
  json.url admin_account_detail_url(admin_account_detail, format: :json)
end
