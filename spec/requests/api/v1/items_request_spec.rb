require 'rails_helper'

describe 'Items API' do
  it 'can return a list of items' do
    items = create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_items = JSON.parse(response.body)

    expect(response_items.count).to eq(3)
    expect(response_items.first["id"]).to eq(items.first.id)
    expect(response_items.first["name"]).to eq(items.first.name)
    expect(response_items.first["description"]).to eq(items.first.description)
    expect(response_items.first["image_url"]).to eq(items.first.image_url)
    expect(response_items.first["created_at"]).to eq(nil)
    expect(response_items.first["updated_at"]).to eq(nil)
  end
  it 'can return a single item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_success
    expect(response.status).to eq(200)

    response_item = JSON.parse(response.body)

    expect(response_item["id"]).to eq(item.id)
    expect(response_item["name"]).to eq(item.name)
    expect(response_item["description"]).to eq(item.description)
    expect(response_item["image_url"]).to eq(item.image_url)
    expect(response_item["created_at"]).to eq(nil)
    expect(response_item["updated_at"]).to eq(nil)
  end

  it 'can delete a single item' do
    item = create(:item)
    id = item.id

    expect{ delete "/api/v1/items/#{id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect(response.status).to eq(204)
    expect{ Item.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end