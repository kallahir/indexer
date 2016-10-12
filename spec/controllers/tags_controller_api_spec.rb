require 'rails_helper'

describe "Testing TAGs API", :type => :request do
  
  context 'in case of no data' do
    it 'get all tags' do
      get '/tags'
      
      json = JSON.parse(response.body)

      expect(json).to eq([])
    end
  end
  
  context 'in case of no data' do
    it 'get all tags' do
      post '/urls', params: { url_path: "www.jovemnerd.com.br"}, as: :json
      get '/tags'
      
      json = JSON.parse(response.body)
      
      expect(json.size).to be > 1
    end
  end
  
end