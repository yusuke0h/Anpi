class User < ActiveRecord::Base
  config = YAML.load_file('config/outside_database.yml')
  establish_connection(config["db"])

  has_many :confirmations
  self.primary_key = "id"
end
