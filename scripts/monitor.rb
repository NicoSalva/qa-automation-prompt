require 'sqlite3'
require 'net/http'
require 'json'

# Conexión a la base de datos
db_path = File.expand_path('../database/request_logs.db', __dir__)
db = SQLite3::Database.new db_path

# Función para registrar respuestas
def log_response(db, url, name_param, status_code, response_body)
  db.execute('INSERT INTO request_logs (url, name_parameter, response_status, response_text) VALUES (?, ?, ?, ?)',
             [url, name_param, status_code, response_body])
end

# URL del endpoint a monitorear
url = URI.parse('https://qa-challenge-nine.vercel.app/api/name-checker')

# Nombres para probar
test_names = [
  "John",          # Nombre válido
  "Alice",         # Nombre válido
  "",              # Vacío
  " ",             # Espacio en blanco
  nil,             # Nulo
  "1234",          # Solo números
  "!@#$%",         # Caracteres especiales
  "A very very very long name that might exceed limits", # Nombre largo
  "中文测试",         # Caracteres no ASCII
  "John123",       # Nombre alfanumérico
]

test_names.each do |name|
  begin
    uri = URI("#{url}?name=#{name}")
    response = Net::HTTP.get_response(uri)

    # Inserta un log en la base de datos
    log_response(db, url.to_s, name, response.code.to_i, response.body)
    puts "Logged response for name '#{name}': #{response.code}"

  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end



