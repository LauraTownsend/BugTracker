#!/usr/bin/env ruby
#A server written in Ruby for a bug tracker
#using sinatra for handling http requests
#Author: Laura McCormack

#require statements
require 'sinatra'
require 'haml'
require 'mongo'

#set the format for all haml docs used
set :haml, :format => :html5

#set up connection to mongo
conn = Mongo::Connection.new
#create/use the bugDB database
db = conn.db("bugDB")
#create/use the bugs collection
coll = db["bugs"]

get '/' do 
	haml :index
end

get '/bug/:id' do 
	
end