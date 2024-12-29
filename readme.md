```markdown
# QA Automation Challenge: API Monitoring and Bug Detection

Este proyecto realiza un monitoreo continuo de un servicio REST para calcular su uptime y detectar patrones en un bug relacionado con el parámetro `name`.

## Requisitos

Antes de comenzar, asegúrate de tener instalado en tu máquina:

- **Ruby** (versión 3.2.2 o superior).
- **Bundler** (administrador de dependencias de Ruby).
- **SQLite3** (base de datos).

Verifica las versiones instaladas ejecutando:
```bash
ruby -v
bundler -v
sqlite3 --version
```

---

## Instalación

1. **Clona este repositorio:**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd qa-challenge
   ```

2. **Instala las dependencias del proyecto:**
   ```bash
   bundle install
   ```

3. **Inicializa la base de datos SQLite3:**
   Ejecuta el archivo `schema.sql` para crear las tablas necesarias:
   ```bash
   sqlite3 database/request_logs.db < database/schema.sql
   ```

4. **Verifica la tabla creada:**
   ```bash
   sqlite3 database/request_logs.db
   .tables
   ```
   Deberías ver la tabla `request_logs`.

---

## Ejecución del monitoreo

1. **Ejecuta el script de monitoreo:**
   Este script enviará solicitudes al endpoint cada segundo y registrará las respuestas en la base de datos.
   ```bash
   ruby scripts/monitor.rb
   ```

2. **Consulta los registros en la base de datos:**
   Para ver los datos almacenados, ejecuta:
   ```bash
   sqlite3 database/request_logs.db
   SELECT * FROM request_logs;
   ```

---

## Cálculo del uptime

1. **Ejecuta el script para calcular el uptime:**
   Este script leerá los registros de la base de datos y calculará el porcentaje de tiempo en el que el servicio respondió correctamente (código 200).
   ```bash
   ruby scripts/calculate_uptime.rb
   ```

2. **Salida esperada:**
   El script imprimirá en la consola algo como:
   ```plaintext
   Total de solicitudes: 100
   Solicitudes exitosas: 80
   Porcentaje de uptime: 80.0%
   ```

---

## Análisis del Bug

1. **Modifica el array de `test_names` en el script `monitor.rb`:**
   Puedes incluir valores específicos para probar y detectar el patrón del bug.
   ```ruby
   test_names = ["John", "Alice", "", "1234", "!@#$%", "中文测试"]
   ```

2. **Ejecuta nuevamente el script de monitoreo:**
   ```bash
   ruby scripts/monitor.rb
   ```

3. **Revisa los registros en la base de datos:**
   ```bash
   sqlite3 database/request_logs.db
   SELECT name_parameter, response_status, response_text FROM request_logs;
   ```

---

## Notas

- El script de monitoreo debe ejecutarse durante al menos 10 minutos para obtener un cálculo preciso del uptime.
- Incluye la base de datos `request_logs.db` al enviar tu solución.

---