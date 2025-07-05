from flask import Flask
from flask_jwt_extended import JWTManager
from config import Config
from models import db
from routes import bp

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)
JWTManager(app)
app.register_blueprint(bp)

@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
