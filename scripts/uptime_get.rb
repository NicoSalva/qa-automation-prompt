require 'sqlite3'

# Path to the database file
db_path = File.expand_path('../database/request_logs_get.db', __dir__)
db = SQLite3::Database.new db_path

# Query total number of requests and successful requests (status code 200)
total_requests = db.get_first_value('SELECT COUNT(*) FROM request_logs_get').to_f
successful_requests = db.get_first_value('SELECT COUNT(*) FROM request_logs_get WHERE response_status = 200').to_f

# Calculate the uptime percentage
uptime_percentage = (successful_requests / total_requests) * 100

# Display the results
puts "Total requests: #{total_requests.to_i}"
puts "Successful requests: #{successful_requests.to_i}"
puts "Uptime percentage: #{uptime_percentage.round(2)}%"
