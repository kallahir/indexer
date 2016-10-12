require 'open-uri'
require 'open_uri_redirections'

class UrlsController < ApplicationController

  def create
    #1. verificar se o json é valido
    if params.has_key?(:url_path) == false
      render json: {error: "invalid json"}
      return
    end
    
    #2. verificar se url é valida
    #2.1. verificar se url começa com http/https
    unless params[:url_path].downcase.start_with?('http://','https://')
      render json: {error: "invalid url (missing HTTP or HTTPS)"}
      return
    end
    
    #2.2. verificar se url já foi indexida
    if Url.find_by(url_path: params[:url_path]) != nil
      render json: {error: "url already indexed"}
      return
    end
    
    #3. extrair tags da url
    begin
      url_content = Nokogiri::HTML(open(params[:url_path], allow_redirections: :all))
    rescue Errno::ENOENT, SocketError
      render json: {error: "url not found"}
      return
    end
    
    @url = Url.new(url_params)
    tags_type = ['h1','h2','h3']
    
    tags_type.each do |tag_type| 
      save_url_tags(url_content, tag_type, @url)
    end
    
    if @url.save
      render json: @url, status: :created, location: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  private
    def url_params
      params.require(:url).permit(:url_path)
    end
    
    def save_url_tags(url_content, tag_type, url)
      url_content.css(tag_type).each do |tag|
        @tag = Tag.new(tag_content: tag.content, tag_type: tag_type)
        @tag.url = url
        @tag.save
      end
    end
end
