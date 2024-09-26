from typing import List

from returns.maybe import Maybe

from config.base import session_factory
from model import Target

def get_all_missions() -> List[Target]:
    with session_factory() as session:
        return session.query(Target).all()

def get_mission_by_id(target_id: int) -> Maybe[Target]:
    with session_factory() as session:
        return Maybe.from_optional(session.query(Target).get(target_id))
