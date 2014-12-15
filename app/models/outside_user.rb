class OutsideUser < ActiveRecord::Base
  config = YAML.load_file('config/outside_database.yml')
  establish_connection(config["db"])
  self.primary_key = "id"
end