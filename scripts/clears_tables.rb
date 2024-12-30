require 'sqlite3'

# Function to clear specific tables in the database
def clear_database(db_path)
  db = SQLite3::Database.new db_path
  begin
    db.execute('DELETE FROM request_logs_get') # Clear GET table
    db.execute('DELETE FROM request_logs_post') # Clear POST table
    puts "All tables in '#{db_path}' cleared."
  rescue SQLite3::SQLException => e
    puts "Error clearing tables in '#{db_path}': #{e.message}"
  end
end

# Paths to GET and POST databases
db_get_path = File.expand_path('../database/request_logs_get.db', __dir__)
db_post_path = File.expand_path('../database/request_logs_post.db', __dir__)

# Clear both databases
clear_database(db_get_path)
clear_database(db_post_path)
