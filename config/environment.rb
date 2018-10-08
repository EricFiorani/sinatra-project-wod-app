ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
#using the establish_connection method from ActiveRecord::Base to connect
#to our users database, which will be created in the migration via SQLite3 (the adapter).
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
                #used for local host
)

require_all 'app'
