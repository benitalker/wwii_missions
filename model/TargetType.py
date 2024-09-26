from sqlalchemy import Column, Integer, String
from config.base import Base

class TargetType(Base):
    __tablename__ = "TargetTypes"

    target_type_id = Column(Integer, primary_key=True, autoincrement=True)
    target_type_name = Column(String(255), unique=True, nullable=False)

    def __repr__(self):
        return f"<TargetType(target_type_id={self.target_type_id}, target_type_name={self.target_type_name})>"
