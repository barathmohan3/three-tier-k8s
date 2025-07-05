from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from models import db, Employee

bp = Blueprint('routes', __name__)

@bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if data.get('username') == 'admin' and data.get('password') == 'admin':
        token = create_access_token(identity='admin')
        return jsonify(access_token=token)
    return jsonify({"msg": "Bad credentials"}), 401

@bp.route('/api/employees', methods=['GET'])
@jwt_required()
def list_employees():
    return jsonify([e.to_dict() for e in Employee.query.all()])

@bp.route('/api/employees', methods=['POST'])
@jwt_required()
def add_employee():
    data = request.get_json()
    emp = Employee(name=data['name'], department=data['department'])
    db.session.add(emp)
    db.session.commit()
    return jsonify(emp.to_dict()), 201
