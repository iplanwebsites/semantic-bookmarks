

uri =  URI.parse(ENV['MONGOHQ_URL'])
@mongo_connection = Mongo::Connection.from_uri( uri )
@mongo_db = @mongo_connection.db(uri.path.gsub(/^\//, ''))
@mongo_db.authenticate(uri.user, uri.password)

