require 'sqlite3'
require 'net/http'
require 'json'


db_path = File.expand_path('../database/request_logs_get.db', __dir__)
db = SQLite3::Database.new db_path

def log_response_get(db, url, name_param, status_code, response_body)
  db.execute('INSERT INTO request_logs_get (url, name_parameter, response_status, response_text) VALUES (?, ?, ?, ?)',
             [url, name_param, status_code, response_body])
end

url = URI.parse('https://qa-challenge-nine.vercel.app/api/name-checker')

test_names = ["John", "Alice", "", "1234", "!@#$%", "中文测试"]


start_time = Time.now
duration = 10 * 60 


while Time.now - start_time < duration
  test_names.each do |name|
    begin
      uri = URI("#{url}?name=#{URI.encode_www_form_component(name)}")
      response = Net::HTTP.get_response(uri)

      log_response_get(db, url.to_s, name, response.code.to_i, response.body)
      puts "Logged GET response for name '#{name}': #{response.code}"
    rescue StandardError => e
      puts "Error: #{e.message}"
    end

    sleep 1
  end
end

puts "GET monitoring complete."




