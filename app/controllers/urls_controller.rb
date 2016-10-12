require 'open-uri'
require 'open_uri_redirections'

class UrlsController < ApplicationController

  def create
    if params.has_key?(:url_path) == false
      render json: { error: { message: "invalid json" } }
      return
    end
    
    @url_path = params[:url_path]

    unless @url_path.downcase.start_with?('http://','https://')
      @url_path.prepend('http://')
    end
    
    if @url_path.downcase.start_with?('https://')
      @url_path = @url_path.gsub('https://','http://')
    end
    
    if Url.find_by(url_path: @url_path) != nil
      render json: { error: { message: "url already indexed" } }
      return
    end
    
    begin
      url_content = Nokogiri::HTML(open(@url_path, allow_redirections: :all))  
    rescue Errno::ENOENT, SocketError
      render json: { error: { message: "url not found" } }
      return
    end
    
    @url = Url.new(url_path: @url_path)
    
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
    def save_url_tags(url_content, tag_type, url)
      url_content.css(tag_type).each do |tag|
        @tag = Tag.new(tag_content: tag.content, tag_type: tag_type)
        @tag.url = url
        @tag.save
      end
    end
    
end
