from flask import Blueprint, request, jsonify
from repository.target_repository import insert_target, get_target_by_id, get_all_targets, update_target, delete_target
from model import Target
from returns.result import Success
from returns.maybe import Nothing
from dictalchemy.utils import asdict

target_blueprint = Blueprint('target_blueprint', __name__)

@target_blueprint.route('/target', methods=['POST'])
def create_target():
    data = request.json
    target = Target(
        target_industry=data['target_industry'],
        target_priority=data['target_priority'],
        city_id=data['city_id'],
        target_type_id=data['target_type_id']
    )

    result = insert_target(target)

    if isinstance(result, Success):
        res = result.unwrap()
        return jsonify(asdict(res)), 201
    return jsonify({"error": result.failure()}), 400

@target_blueprint.route('/target/<int:target_id>', methods=['GET'])
def get_target(target_id):
    maybe_target = get_target_by_id(target_id)

    if maybe_target is Nothing:
        return jsonify({"error": "Target not found"}), 404
    res = maybe_target.unwrap()
    return jsonify(asdict(res))

@target_blueprint.route('/target', methods=['GET'])
def get_targets():
    targets = get_all_targets()
    dict_targets = list(map(asdict, targets))
    return jsonify(dict_targets)

@target_blueprint.route('/target/<int:target_id>', methods=['PUT'])
def update_target_by_id(target_id):
    data = request.json
    target = Target(
        target_industry=data['target_industry'],
        target_priority=data['target_priority'],
        city_id=data['city_id'],
        target_type_id=data['target_type_id']
    )

    result = update_target(target_id, target)

    if isinstance(result, Success):
        res = result.unwrap()
        return jsonify(asdict(res))
    return jsonify({"error": result.failure()}), 400

@target_blueprint.route('/target/<int:target_id>', methods=['DELETE'])
def delete_target_by_id(target_id):
    result = delete_target(target_id)

    if isinstance(result, Success):
        return jsonify({"message": f"Target with id {target_id} deleted successfully"}), 200
    return jsonify({"error": result.failure()}), 400
