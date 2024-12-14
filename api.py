from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)

# MySQL Database configuration
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "root"
app.config["MYSQL_DB"] = "preserved"
app.config["SECRET_KEY"] = "your_secret_key"

# Initialize MySQL
mysql = MySQL(app)

# Default route
@app.route('/')
def index():
    return jsonify({'message': 'Welcome to the Railway Lines API'}), 200

# CRUD Endpoints
@app.route('/railway_lines', methods=['GET'])
def get_railway_lines():
    # try:
        cursor = mysql.connection.cursor()
        cursor.execute('SELECT * FROM railway_lines')
        lines = cursor.fetchall()
        cursor.close()
        return jsonify(lines), 200
    # except Exception as e:
    #     return jsonify({'error': str(e)}), 500

@app.route('/railway_lines/<int:line_number>', methods=['GET'])
def get_railway_line(line_number):
    try:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM railway_lines WHERE line_number = %s', (line_number,))
        line = cursor.fetchone()
        cursor.close()
        
        if not line:
            return jsonify({'error': 'Railway line not found'}), 404
        return jsonify(line), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/railway_lines', methods=['POST'])
def create_railway_line():
    try:
        data = request.get_json()
        cursor = mysql.connection.cursor()
        cursor.execute('''
            INSERT INTO railway_line 
            (line_number, class_code, origin_code, type_code, line_name, address, phone_number, total_miles, year_opened)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ''', (
            data['line_number'],
            data['class_code'],
            data['origin_code'],
            data['type_code'],
            data['line_name'],
            data.get('address'),
            data.get('phone_number'),
            data.get('total_miles'),
            data.get('year_opened')
        ))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'message': 'Railway line created successfully'}), 201
    except KeyError as e:
        return jsonify({'error': f'Missing field: {str(e)}'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/railway_lines/<int:line_number>', methods=['PUT'])
def update_railway_line(line_number):
    try:
        data = request.get_json()
        cursor = mysql.connection.cursor()
        update_fields = []
        values = []
        
        for key, value in data.items():
            if key in ['class_code', 'origin_code', 'type_code', 'line_name', 'address', 'phone_number', 'total_miles', 'year_opened']:
                update_fields.append(f'{key} = %s')
                values.append(value)
        
        if update_fields:
            values.append(line_number)
            query = f'UPDATE railway_line SET {", ".join(update_fields)} WHERE line_number = %s'
            cursor.execute(query, tuple(values))
            mysql.connection.commit()
            cursor.close()
            return jsonify({'message': 'Railway line updated successfully'}), 200
        return jsonify({'message': 'No fields to update'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/railway_lines/<int:line_number>', methods=['DELETE'])
def delete_railway_line(line_number):
    try:
        cursor = mysql.connection.cursor()
        cursor.execute('DELETE FROM railway_line WHERE line_number = %s', (line_number,))
        mysql.connection.commit()
        cursor.close()
        
        if cursor.rowcount == 0:
            return jsonify({'error': 'Railway line not found'}), 404
        return jsonify({'message': 'Railway line deleted successfully'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
