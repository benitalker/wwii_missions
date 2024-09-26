from typing import List, Optional
from returns.maybe import Maybe
from config.base import session_factory
from model import Mission


def get_all_missions(limit: Optional[int] = None) -> List[Mission]:
    with session_factory() as session:  # Use your session context manager
        query = session.query(Mission)
        if limit is not None:
            query = query.limit(limit)
        return query.all()

def get_mission_by_id(target_id: int) -> Maybe[Mission]:
    with session_factory() as session:
        return Maybe.from_optional(session.query(Mission).get(target_id))
