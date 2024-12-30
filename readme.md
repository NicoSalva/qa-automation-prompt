# QA Automation Challenge: API Monitoring and Bug Detection

This project continuously monitors a REST service to calculate its uptime and detect patterns in a bug related to the `name` parameter.

## Introduction

This solution focuses on analyzing the POST requests, as they provide the most meaningful responses for identifying and understanding the bug. However, the project also supports monitoring GET requests, offering flexibility for additional analysis if required. Both GET and POST monitoring scripts log responses into separate SQLite3 databases for clarity and ease of use.

---

## Requirements

Before starting, ensure you have the following installed on your machine:

- **Ruby** (version 3.2.2 or higher).
- **Bundler** (Ruby dependency manager).
- **SQLite3** (database).

Verify the installed versions by running:

```
ruby -v
```
bundler -v
```
```
sqlite3 --version
```

## Installation

1. **Clone this repository:**
  
   ```
   git clone <REPOSITORY_URL>
   cd qa-challenge
   ```

2. **Install project dependencies:**
   
   ```
   bundle install
   ```

3. **Initialize the SQLite3 database for GET and POST requests:**
   Run the `schema.sql` file to create the necessary tables:
   
   ```
   sqlite3 database/request_logs_get.db < database/schema.sql
   sqlite3 database/request_logs_post.db < database/schema.sql
   ```

4. **Verify the created tables:**
   ```
   sqlite3 database/request_logs_get.db
   .tables
   ```
   You should see the `request_logs_get` table.
   ```
   sqlite3 database/request_logs_post.db
   .tables
   ```
   You should see the `request_logs_post` table.

---

## Running the Monitoring Scripts

### Monitoring GET Requests
1. **Run the GET monitoring script:**
   This script will send GET requests to the endpoint every second and log the responses into the `request_logs_get.db` database.
   ```
   ruby scripts/monitor_get.rb
   ```

2. **Check the logged data for GET requests:**
   To view the stored logs, run:
   ```
   sqlite3 database/request_logs_get.db
   SELECT * FROM request_logs_get;
   ```

### Monitoring POST Requests
1. **Run the POST monitoring script:**
   This script will send POST requests to the endpoint every second and log the responses into the `request_logs_post.db` database.
   ```
   ruby scripts/monitor_post.rb
   ```

2. **Check the logged data for POST requests:**
   To view the stored logs, run:
   ```
   sqlite3 database/request_logs_post.db
   SELECT * FROM request_logs_post;
   ```

---

## Calculating Uptime

### Calculating GET Request Uptime
1. **Run the uptime calculation script for GET requests:**
   This script reads the `request_logs_get.db` database and calculates the uptime percentage for GET requests.
   ```
   ruby scripts/uptime_get.rb
   ```

2. **Expected Output:**
   ```plaintext
   Total requests: 100
   Successful requests: 80
   Uptime percentage: 80.0%
   ```

### Calculating POST Request Uptime
1. **Run the uptime calculation script for POST requests:**
   This script reads the `request_logs_post.db` database and calculates the uptime percentage for POST requests.
   ```
   ruby scripts/uptime_post.rb
   ```

2. **Expected Output:**
   ```plaintext
   Total requests: 100
   Successful requests: 70
   Uptime percentage: 70.0%
   ```

---

## Resetting the Databases

 **Clear both GET and POST databases:**
   Run the script to clear all records from both `request_logs_get` and `request_logs_post` databases:
```
cd path/to/scripts
ruby clears_tables.rb
```

---

## Bug Analysis

### Analyzing POST Requests
1. **Modify `test_names` in `monitor_post.rb`:**
   Update the `test_names` array to include specific values to test the bug patterns.
   ```ruby
   test_names = ["John", "Alice", "", "1234", "!@#$%", "中文测试"]
   ```

2. **Run the POST monitoring script:**
   ```
   ruby scripts/monitor_post.rb
   ```

3. **Analyze the results:**
   Query the `request_logs_post.db` database to check for specific response patterns:
   ```
   sqlite3 database/request_logs_post.db
   SELECT name_parameter, response_status, response_text FROM request_logs_post;
   ```

---

## Notes

- The monitoring scripts should run for at least 10 minutes to obtain accurate uptime calculations.
- Include the `request_logs_get.db` and `request_logs_post.db` files when submitting your solution.
- While the bug appears more evident in POST requests, both GET and POST analyses are supported.

