require 'dm-types'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :length => (5..100), :unique => true, :format => :email_address, :required => true
  property :password, BCryptHash, :required => true
  property :cookie, String
  property :created_at, DateTime

  def json_hash
    {
      :cookie =>  self.cookie,
      :created_at => self.created_at,
      :id => self.id,
      :email => self.email
    }
  end

  def to_json
    self.json_hash.to_json
  end

end

DataMapper.finalize
