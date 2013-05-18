require 'sinatra' # framework for web app
require 'haml' # templates
require_relative 'helpers.rb' # helper methods

# enable :sessions
# set :dump_errors, false
# set :show_exceptions, false

get '/' do
  "API site"
end

get '/widget/author/:author' do
  haml "api response", :layout => false
end

error 404 do
  haml "Sorry, that page doesn't exist."
end
