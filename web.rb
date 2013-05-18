require 'sinatra'
require 'haml'
require 'uri'
require 'json'
require 'httparty'
require_relative 'helpers.rb' # helper methods

set :protection, :except => :frame_options

get '/' do
  haml :input
end

post '/' do
  q = URI.escape params[:query]
  redirect "/widget/search/#{q}"
end

# readmill api keys
# ID: cebbc653b49578b9d02a7c23a89dc5e3
# Secret: 78880e3439585251be67329551092fba

get '/widget/search/:query' do
  @query = params[:query]
  url = URI.escape "https://api.readmill.com/v2/books/search?query=#{@query}&client_id=cebbc653b49578b9d02a7c23a89dc5e3"
  hash = HTTParty.get url
  @books = hash["items"]
  puts @books
  haml :search
end

error 404 do
  haml "Sorry, that page doesn't exist."
end
