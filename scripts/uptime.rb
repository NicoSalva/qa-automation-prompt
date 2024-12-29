require 'sqlite3'

# Conexión a la base de datos
db_path = File.expand_path('../database/request_logs.db', __dir__)
db = SQLite3::Database.new db_path

# Consulta para obtener todos los registros
logs = db.execute('SELECT response_status FROM request_logs')

# Contar el total de solicitudes y las exitosas
total_requests = logs.size
successful_requests = logs.count { |log| log[0] == 200 }

# Calcular el porcentaje de uptime
uptime_percentage = if total_requests > 0
                      (successful_requests.to_f / total_requests * 100).round(2)
                    else
                      0.0
                    end

# Mostrar los resultados
puts "Total de solicitudes: #{total_requests}"
puts "Solicitudes exitosas: #{successful_requests}"
puts "Porcentaje de uptime: #{uptime_percentage}%"
