require 'sqlite3'

# Ruta a la base de datos
db_path = File.expand_path('../database/request_logs.db', __dir__)
db = SQLite3::Database.new db_path

# Consultar el total de solicitudes y las exitosas
total_requests = db.get_first_value('SELECT COUNT(*) FROM logs').to_f
successful_requests = db.get_first_value('SELECT COUNT(*) FROM logs WHERE status_code = 200').to_f

# Calcular el uptime
uptime_percentage = (successful_requests / total_requests) * 100

# Mostrar los resultados
puts "Total de solicitudes: #{total_requests.to_i}"
puts "Solicitudes exitosas: #{successful_requests.to_i}"
puts "Porcentaje de uptime: #{uptime_percentage.round(2)}%"
