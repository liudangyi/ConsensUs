json.extract! decision, :id, :name, :description, :owner, :visibility, :created_at, :updated_at
json.url decision_url(decision, format: :json)