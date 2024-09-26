from flask import Flask
from controller.mission_controller import mission_blueprint
from model import City, Country, Target, TargetType
from repository.database import create_tables, drop_tables

app = Flask(__name__)

app.register_blueprint(mission_blueprint, url_prefix='/api')

if __name__ == '__main__':
    create_tables()
    # app.run(debug=True)
    # drop_tables()
