# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

class CreateLinks < ActiveRecord::Migration
    def change
      create_table :links do |l|
        l.string :url
        l.string :short
      end
    end

    def self.up
    end

    def self.down
    end

end