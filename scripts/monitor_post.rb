require 'sqlite3'
require 'net/http'
require 'json'

# Path to the database file
db_path = File.expand_path('../database/request_logs_post.db', __dir__)
db = SQLite3::Database.new db_path

# Function to log POST responses into the request_logs_post table
def log_response_post(db, url, name_param, status_code, response_body)
  db.execute('INSERT INTO request_logs_post (url, name_parameter, response_status, response_text) VALUES (?, ?, ?, ?)',
             [url, name_param, status_code, response_body])
end

# Endpoint URL
url = URI.parse('https://qa-challenge-nine.vercel.app/api/name-checker')

# List of test names to send as the "name" parameter in the POST body
test_names = ["John", "Alice", "", "1234", "!@#$%", "中文测试"]

# Monitoring duration: 2 minutes
start_time = Time.now
duration = 10 * 60 # in seconds

# Monitoring loop
while Time.now - start_time < duration
  test_names.each do |name|
    begin
      # Initialize HTTP client
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      # Create a POST request
      request = Net::HTTP::Post.new(url.path, { 'Content-Type' => 'application/json' })
      request.body = { name: name }.to_json

      # Send the request and capture the response
      response = http.request(request)

      # Log the response in the database
      log_response_post(db, url.to_s, name, response.code.to_i, response.body)
      puts "Logged POST response for name '#{name}': #{response.code}"

    rescue StandardError => e
      # Handle any errors during the request
      puts "Error: #{e.message}"
    end

    # Wait 1 second before the next request
    sleep 1
  end
end

puts "POST monitoring complete."
