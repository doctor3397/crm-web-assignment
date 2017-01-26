require_relative 'contact'
require 'sinatra'

# Fake data
#Contact.create(first_name: 'Marty', last_name: 'McFly', email: 'marty@mcfly.com', note: 'CEO') #ActiveRecord Method
# Contact.create('George', 'McFly', 'george@mcfly.com', 'Co-Founder')
# Contact.create('Lorraine', 'McFly', 'lorraine@mcfly.com', 'Co-Founder')
# Contact.create('Biff', 'Tannen', 'biff@tannen.com', 'Co-Founder')
# Contact.create('Doc', 'Brown', 'doc@brown.com', 'Co-Founder')

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

# GET /contacts/new (cretae a new contact)
# POST /contacts    (submit the form and save the new contact)

# Add Add a New Contact
# This particular feature is going to require 2 routes:
# 1. GET route to display the form that will let us enter and submit our data,
# 2. POST route that will be in charge of accepting the data your user just submitted, and creating & saving a new contact.

# GET request for form
# Create the Form Route, add the following GET route in crm.rb: "/contacts/new"
get '/contacts/new' do
  erb :new_contact
end

# POST data from form
# Every time your make a request, the params hash is available inside any route block. It's especially useful when you're submitting a form, and it should contain the body of the request.
post '/contacts' do
  # ActiveRecord
  # ActiveRecord automatically provides us with a variety of methods that we can use to create records. One of them is in fact the class method create, which we had previously implemented in the command-line CRM assignment, but deleted as part of transforming Contact into an ActiveRecord model.
  # The ActiveRecord create method expects a hash containing the keys and values of each property in the model, where each key should be the name of a property. In this case, that's first_name, last_name, email, and note.
  @contact = Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  #@contact = Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])

  # Redirect back to the View all contacts page so that we can view our latest addition.
  redirect to('/contacts')

  # puts params
  # We won't create a new contact, we'll just inspect the data submitted by the form.
  # Terminal: {"first_name"=>"Theresa", "last_name"=>"Shen", "email"=>"ts@io", "note"=>"CEO"}
end

# GET /contacts/:id  (show a particular contact)
# GET /contacts/:id/edit  (shows the edit form for a particular contact)
# PUT /contacts/:id  (update a particular contact)
# DELETE /contacts/:id (delete a particular contact)

# GET one contact with ID
# create a route that corresponds to this user. Since URLs are supposed to represent a single resource, if we create the route "/contacts/1", we know exactly which resource we're looking for!
# Inside this route,
# 1. we need to first find our contact,
# 2. and then display the results in a view called
# get '/contacts/1' do
#   @contact = Contact.find(1)
#   erb :show_contact
# end

# Generalize
# Making a generalized route means that instead of defining a route that only matches one thing literally, we can write one that matches a pattern, a wildcard of sorts. Patterns work by putting a colon ahead of the item we want to match and capture.
get '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    # when we can't find the contact matching the request, @contact is nil.
    # return a 404 Not Found response status code if we can't find the resource.
    raise Sinatra::NotFound
  end
end

# GET to edit a contact
# 1. display the edit form
# 2. to handle the form submission.
get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

# PUT request for form submission after editing
# Once we submit the form that we just created, our server will receive a put request to '/contacts/:id', we should create a route to handle this request.
# This route handles a put request about a particular id.
put '/contacts/:id' do
  # params hash will contain the id along with any of information we submitted in the form.
  # With the id from the params, we try to find the contact.
  @contact = Contact.find(params[:id].to_i)

  # If the contact is found, we need to update it.
  if @contact
    @contact.update(
      first_name: params[:first_name],
      last_name:  params[:last_name],
      email:      params[:email],
      note:       params[:note]
    )

    # @contact.first_name = params[:first_name]
    # @contact.last_name = params[:last_name]
    # @contact.email = params[:email]
    # @contact.note = params[:note]

    #  Once it's updated, we want to redirect to our main contacts page.
    redirect to('/contacts')
  else

    # If there's ever any reason we don't find it, we raise the 404 Not Found error.
    raise Sinatra::NotFound
  end
end

# DELETE for delete a contact
# create a route that can handle DELETE '/contacts/:id' request.
# Inside this block, you'll need to remove a contact.
delete '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  # If the contact exists, it should be removed and redirect back to the '/contacts' main page.
  if @contact
    @contact.delete
    redirect to('/contacts')
  # Otherwise, it should raise a 404.
  else
    raise Sinatra::NotFound
  end
end

#Ensuring the database connection is closed
# By default, SQLite allows 5 concurrent connections.
#Unfortunately, MiniRecord will open connections, but it won't close them automatically. What this means is that every 6th time you restart your server, there won't be any connections left and you'll get a mysterious Timeout error.
#
# To fix this, add the following snippet of code to the bottom of your crm.rb file:
#This will close the connection to the database after each request has been responded to.
after do
  ActiveRecord::Base.connection.close
end
