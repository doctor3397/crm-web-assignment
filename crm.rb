# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require_relative 'contact'
require 'sinatra'

# Add some fake data to crm.rb using the Contact class.
# Fake data
Contact.create('Mark', 'Zuckerberg', 'mark@facebook.com', 'CEO')
Contact.create('Sergey', 'Brin', 'sergey@google.com', 'Co-Founder')
Contact.create('Steve', 'Jobs', 'steve@apple.com', 'Visionary')

# create a route. It allows you to match a particular request method and path
# and prepare a specific response for this request.
# This particular route ('/') matches the top level of your website, i.e. The base page of http://localhost:4567.
get '/' do
  # setting up an instance variable @crm_app_name that we'll be able to pass along to our view.
  @crm_app_name = "Theresa's CRM System"

  # Template
  erb :index
end

# View all Contacts
# create a new route that corresponds to a GET request to "/contacts"
get '/contacts' do
  erb :contacts
end

# Add Add a New Contact
# This particular feature is going to require 2 routes:
# 1. the first will be a GET route to display the form that will let us enter and submit our data,
# 2. and the second will be a POST route that will be in charge of accepting the data your user just submitted, and creating & saving a new contact.

# Create the Form Route
# Add the following GET route in crm.rb: "/contacts/new"
get '/contacts/new' do
  erb :new_contact
end
