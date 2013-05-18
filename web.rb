require 'sinatra'
require 'haml'
require 'net/http'
require 'uri'
require 'json'
require 'pp'
require_relative 'helpers.rb' # helper methods

# enable :sessions
# set :dump_errors, false
# set :show_exceptions, false

get '/' do
  "API site"
end

# readmill api keys
# ID: cebbc653b49578b9d02a7c23a89dc5e3
# Secret: 78880e3439585251be67329551092fba
# https://api.readmill.com/v2/books/match?title=Metamorphosis&author=Franz%20Kafka&client_id=cebbc653b49578b9d02a7c23a89dc5e3

get '/widget/search/:query' do
  query = params[:query]
  url = URI.escape "https://api.readmill.com/v2/books/search?query=#{query}&client_id=cebbc653b49578b9d02a7c23a89dc5e3"
  uri = URI.parse url
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  json = http.get(uri.request_uri).body
  hash = JSON.parse(json)
  @books = hash["items"]
  puts @books
  haml :search, :layout => false
  # puts "there are #{books.length || 0} books that match this query"
  # haml json, :layout => false
end

error 404 do
  haml "Sorry, that page doesn't exist."
end
