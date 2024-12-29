require 'sqlite3'

# Ruta absoluta para la base de datos
db_path = File.expand_path('request_logs.db', __dir__)
db = SQLite3::Database.new db_path

# Crear la tabla si no existe
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_code INTEGER NOT NULL,
    response_body TEXT NOT NULL
  );
SQL

puts "Base de datos inicializada correctamente en #{db_path}."
