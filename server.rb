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

##index page
get '/' do 
	haml :index
end

get '/id' do 
	haml :id
end

post '/id' do
	id = params["id"]
	#bug = coll.find_one("id"=>"#{id}").to_s
	puts coll.find("id"=>"#{id}", :fields =>["section"]).to_a
	@id = coll.find("id"=>"#{id}", :fields =>["id"]).to_a
	@section = coll.find("id"=>"#{id}", :fields =>["section"]).to_s
	@content = coll.find("id"=>"#{id}", :fields =>["content"]).to_s
	@contributor = coll.find("id"=>"#{id}", :fields =>["contributor"]).to_s
	@date = coll.find("id"=>"#{id}", :fields =>["date"]).to_s
	@assigned = coll.find("id"=>"#{id}", :fields =>["assigned"]).to_s
	haml :bug
end

get '/contributor' do
	haml :contributor
end

post '/contributor' do
	contributor = params["contributor"]
	bug = coll.find("contributor"=>"#{contributor}").to_a
	puts bug
end

get '/section' do
	haml :section
end

post '/section' do
	section = params["section"]
	bug = coll.find("section"=>"#{section}").to_a
	puts bug
end

get '/date' do
	haml :date
end

post '/date' do
	date = params["date"]
	bug = coll.find("date"=>"#{date}")
	puts bug
end

##adding a bug to the database post on index page
post '/' do
	id = coll.count + 1
	section = params["section"]
	content = params["content"]
	contributor = params["contributor"]
	time = Time.new
	date = "#{time.day}/#{time.month}/#{time.year}"
	assigned = params["assigned"]
	#tags
	bug = {"id"=>"#{id}","section"=>"#{section}","content"=>"#{content}","contributor"=>"#{contributor}","date"=>"#{date}","assigned"=>"#{assigned}"}
	coll.insert(bug)
	haml :success
end



#	application/type JSON
#	Section : not null
#	Content : not null
#	Contributor : not null
# 	Date : not null
#	Assigned to : can be null
#	id : can be assigned programatically but is required
#	tags : can be null