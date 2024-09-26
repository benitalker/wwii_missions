from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from config.base import Base

class Target(Base):
    __tablename__ = "Targets"

    target_id = Column(Integer, primary_key=True, autoincrement=True)
    target_name = Column(String(255), unique=True, nullable=False)
    city_id = Column(Integer, ForeignKey('Cities.city_id'), unique=True, nullable=False)
    target_type_id = Column(Integer, ForeignKey('TargetTypes.target_type_id'))

    city = relationship("City", back_populates="targets",lazy="selectin")
    target_type = relationship("TargetType", back_populates="targets",lazy="selectin")

    def __repr__(self):
        return f"<Target(target_id={self.target_id}, target_name={self.target_name}, city_id={self.city_id}, target_type_id={self.target_type_id})>"
