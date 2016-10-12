require 'open-uri'
require 'open_uri_redirections'

class UrlsController < ApplicationController

  # validar url de entrada
  # validar se url já foi indeixada (http,https)
  # validar json de entrada
  def create
    unless params[:url_path].downcase.start_with?('http://','https://')
      render json: {error: "invalid url"}
      return
    end
    
    begin
      url_content = Nokogiri::HTML(open(params[:url_path], allow_redirections: :all))
    rescue Errno::ENOENT, SocketError
      render json: {error: "invalid url"}
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
