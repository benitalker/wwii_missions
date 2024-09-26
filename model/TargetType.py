from sqlalchemy import Column, Integer, String, Sequence
from sqlalchemy.orm import relationship
from config.base import Base

class TargetType(Base):
    __tablename__ = 'TargetTypes'
    target_type_id = Column(Integer, Sequence('target_type_id_seq'), primary_key=True)
    target_type_name = Column(String(255), unique=True, nullable=False)

    def __repr__(self):
        return (f"<TargetType(target_type_id={self.target_type_id}, "
                f"target_type_name='{self.target_type_name}')>")
