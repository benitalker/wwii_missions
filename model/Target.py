from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from config.base import Base

class Target(Base):
    __tablename__ = "targets"

    target_id = Column(Integer, primary_key=True, autoincrement=True)
    target_industry = Column(String(255), nullable=False)
    target_priority = Column(Integer)
    city_id = Column(Integer, ForeignKey('Cities.city_id'), nullable=False)
    target_type_id = Column(Integer, ForeignKey('TargetTypes.target_type_id'))

    city = relationship("City", back_populates="targets")
    target_type = relationship("TargetType", back_populates="targets")

    def __repr__(self):
        return (f"<Target(target_id={self.target_id}, target_industry='{self.target_industry}', "
                f"target_priority={self.target_priority}, city_id={self.city_id}, "
                f"target_type_id={self.target_type_id})>")
