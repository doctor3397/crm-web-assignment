# Copy your entire Contact class from the old crm assignment here.
# Then, run the following at the command line:
#
#   ruby test/contact_test.rb
#
# If your implementation of the Contact class is 'right', then you should see that all tests pass!

class Contact

  attr_accessor :first_name, :last_name, :email, :note
  attr_reader :id

  #   Class variables
  @@contacts = []
  @@id = 1

  # Initialize method
  def initialize(first_name, last_name, email, note)
    @first_name = first_name # store in the instance variables
    @last_name = last_name
    @email = email
    @note = note

    @id = @@id
  end

  # Create new Contacts
  def self.create(first_name, last_name, email, note)
    # 1. Initialize a new Contact with a unique ID
    new_contact = self.new(first_name, last_name, email, note)

    # 2. Add the new Contact to the contacts list
    @@contacts << new_contact

    # 3. increment the next unique ID
    @@id += 1

    # 4. Return the newly created contacts
    new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    @@contacts
  end

  # This method should accept an id as an argument and return the contact who has that id
  def self.find(id)
    @@contacts.find { |contact| contact.id == id }
  end
  # def self.find(id)
  #   @@contacts.each do |contact|
  #     if contact.id == id
  #       return contact
  #     end
  #   end
  # end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, value)

    case attribute
      when "first_name"
        self.first_name = value
      when "last_name"
        self.last_name = value
      when "email"
        self.email = value
      when "note"
        self.note = value
    end

  end

  # This method allows you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute, value)

    @@contacts.each do |contact|

      case attribute
        when "first_name"
          if contact.first_name == value
            return contact
          end
        when "last_name"
          if contact.last_name == value
            return contact
          end
        when "email"
          if contact.email == value
            return contact
          end
        when "note"
          if contact.note == value
            return contact
          end
      end
    end

  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts = []
  end

  def full_name
    "#{first_name} #{last_name}" # Method calls
  end

  # This method should delete the contact
  def delete
    @@contacts.delete(self)
  end

end
