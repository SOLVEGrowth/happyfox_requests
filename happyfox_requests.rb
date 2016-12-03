require 'sinatra'
require 'json'
require 'rest-client'

USER_NAME = '1b4b5322499d44ae9579c78f97074e8c'
PASSWORD  = 'fbd661ba1ac94b3782ae2e2a5ef6225a'
HF_URL    = "https://medbilliq.happyfox.com/api/1.1/json/users/"

get '/users.json' do
	content_type :json
  get_users_json	
end

post '/users.json' do
	content_type :json
#	{ :key1 => 'value1', :key2 => 'value2' }.to_json
  post_users_json params
end

def get_users_json
	#JSON.parse (rest_client_request :get, HF_URL).body
	(rest_client_request :get, HF_URL).body
end

# Can be only one user. If user exists, HF just updates user entry.
def post_users_json payload
	JSON.parse ( rest_client_request :post, HF_URL, payload ).body
end

def rest_client_request method, url, payload={}
	args = { method: method, url: url, user: USER_NAME, password: PASSWORD }
	args[:payload] = payload unless payload.empty?
	RestClient::Request.execute args
end
