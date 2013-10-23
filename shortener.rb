require 'sinatra'
require 'active_record'
require 'pry'
require 'digest/sha1'

###########################################################
# Configuration
###########################################################

set :public_folder, File.dirname(__FILE__) + '/public'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class Link < ActiveRecord::Base
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = Link.order("url DESC") # FIXME
    erb :index
end

get '/new' do
    erb :form
end

get '/:name' do |n|
  record = Link.where("code = ?", n)[0]
  redirect to(record.url)
end

post '/new' do
  url = params["url"]
  if !url.start_with?("http://")
    url.start_with?("www.") ? url.prepend("http://") : url.prepend("http://www.")
  end
  record = Link.where("url = ?", url)[0]
  puts record
  if record
    record.code
  else
    @link = Link.new
    @link.url = url
    @link.code = Digest::SHA1.hexdigest url
    if @link.save
      @link.code
    else
      puts "error"
    end
  end
end