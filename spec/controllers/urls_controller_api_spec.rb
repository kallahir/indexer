require 'rails_helper'

describe "Testing URLs API", :type => :request do
  
  context 'in case of invalid json' do
    it 'invalid_json' do
      post '/urls', params: { url_pathx: "www.jovemnerd.com.br"}, as: :json

      json = JSON.parse(response.body)

      expect(response).to be_success
    
      expect(json['error']['message']).to eq('invalid json')
    end
  end
  
  context 'in case of invalid url' do
    it 'url_not_found' do
      post '/urls', params: { url_path: "www.jovemXXXnerd.com.br"}, as: :json

      json = JSON.parse(response.body)

      expect(response).to be_success
    
      expect(json['error']['message']).to eq('url not found')
    end
  end
  
  context 'in case of already indexed url' do
    it 'url_already_indexed' do
      post '/urls', params: { url_path: "www.jovemnerd.com.br"}, as: :json
      post '/urls', params: { url_path: "http://www.jovemnerd.com.br"}, as: :json
      
      json = JSON.parse(response.body)
    
      expect(json['error']['message']).to eq('url already indexed')
    end
  end
  
  context 'in case of valid url' do
    it 'url_valid_without_http_or_https' do
      post '/urls', params: { url_path: "www.jovemnerd.com.br"}, as: :json
      
      json = JSON.parse(response.body)
    
      expect(json['id']).to eq(1)
      expect(json['url_path']).to eq('http://www.jovemnerd.com.br')
    end
    
    it 'url_valid_with_http' do
      post '/urls', params: { url_path: "http://www.jovemnerd.com.br"}, as: :json
      
      json = JSON.parse(response.body)
    
      expect(json['id']).to eq(1)
      expect(json['url_path']).to eq('http://www.jovemnerd.com.br')
    end
    
    it 'url_valid_with_https' do
      post '/urls', params: { url_path: "https://www.jovemnerd.com.br"}, as: :json
      
      json = JSON.parse(response.body)
    
      expect(json['id']).to eq(1)
      expect(json['url_path']).to eq('http://www.jovemnerd.com.br')
    end
  end
  
end