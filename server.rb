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

get '/id' do 
	haml :getByID
end

post '/id' do
	
end

get '/contributor' do
	haml :getByContributor
end

get '/section' do
	haml :getBySection
end

get '/date' do
	haml :getByDate
end

post '/' do
	section = params["section"]
	content = params["content"]
	contributor = params["contibutor"]
	date = params["date"]
	assigned = params["assigned"]
	id = params["id"] ##TODO : assign id programmatically instead of manually
	#tags
	bug = {"section"=>"#{section}","content"=>"#{content}","contributor"=>"#{contributor}","date"=>"#{date}","assigned"=>"#{assigned}","id"=>"#{id}"}
	coll.insert(bug)
end



#	application/type JSON
#	Section : not null
#	Content : not null
#	Contributor : not null
# 	Date : not null
#	Assigned to : can be null
#	id : can be assigned programatically but is required
#	tags : can be null