# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require 'sinatra'

# create a route. It allows you to match a particular request method and path
# and prepare a specific response for this request.
# This particular route ('/') matches the top level of your website, i.e. The base page of http://localhost:4567.
get '/' do
  erb :index
end
