import os
import uuid
import boto3
from flask import Flask, request, redirect, jsonify

app = Flask(__name__)

TABLE_NAME = os.environ.get('TABLE_NAME')
dynamodb = boto3.resource('dynamodb', region_name='eu-west-2')
table = dynamodb.Table(TABLE_NAME)

@app.route('/healthz', methods=['GET'])
def health_check():
    return jsonify({"status": "ok"}), 200

@app.route('/shorten', methods=['POST'])
def shorten_url():
    data = request.get_json()
    long_url = data.get('url')
    if not long_url:
        return jsonify({"error": "URL is required"}), 400

    short_code = str(uuid.uuid4())[:8]
    table.put_item(Item={'id': short_code, 'url': long_url})
    
    return jsonify({"short": short_code, "url": long_url}), 201

@app.route('/<short_code>', methods=['GET'])
def redirect_to_url(short_code):
    response = table.get_item(Key={'id': short_code})
    item = response.get('Item')
    if not item:
        return jsonify({"error": "URL not found"}), 404
    
    return redirect(item['url'], code=302)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
