require_relative 'contact'
require 'sinatra'

# Fake data
Contact.create('Marty', 'McFly', 'marty@mcfly.com', 'CEO')
Contact.create('George', 'McFly', 'george@mcfly.com', 'Co-Founder')
Contact.create('Lorraine', 'McFly', 'lorraine@mcfly.com', 'Co-Founder')
Contact.create('Biff', 'Tannen', 'biff@tannen.com', 'Co-Founder')
Contact.create('Doc', 'Brown', 'doc@brown.com', 'Co-Founder')

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

# GET request for form
# Create the Form Route, add the following GET route in crm.rb: "/contacts/new"
get '/contacts/new' do
  erb :new_contact
end

# POST data from form
# We won't create a new contact, we'll just inspect the data submitted by the form.
# In order to do this, we'll do a puts statement on the params.
# Every time your make a request, the params hash is available inside any route block. It's especially useful when you're submitting a form, and it should contain the body of the request.
post '/contacts' do
  @contact = Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  #erb :contact_created

  # REDIRECT back to top level
  # Redirect back to the View all contacts page so that we can view our latest addition.
  redirect to('/contacts')
  #erb :contacts
  # puts params
  # Terminal
  # {"first_name"=>"Theresa", "last_name"=>"Shen", "email"=>"ts@io", "note"=>"CEO"}
end

 # create a route that corresponds to this user. Since URLs are supposed to represent a single resource, if we create the route "/contacts/1", we know exactly which resource we're looking for!
 # Inside this route,
 # 1. we need to first find our contact,
 # 2. and then display the results in a view called 
get '/contacts/1' do
  @contact = Contact.find(1)
  erb :show_contact
end
