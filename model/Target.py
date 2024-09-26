from sqlalchemy import Column, Integer, String, ForeignKey, Sequence
from sqlalchemy.orm import relationship
from config.base import Base

class Target(Base):
    __tablename__ = 'Targets'
    target_id = Column(Integer, Sequence('target_id_seq'), primary_key=True)
    target_industry = Column(String(255), nullable=False)
    city_id = Column(Integer, ForeignKey('Cities.city_id'), nullable=False)
    target_type_id = Column(Integer, ForeignKey('TargetTypes.target_type_id'), nullable=True)
    target_priority = Column(Integer, nullable=True)

    city = relationship("City")
    target_type = relationship("TargetType")

    def __repr__(self):
        return (f"<Target(target_id={self.target_id}, target_industry='{self.target_industry}', "
                f"target_priority={self.target_priority}, city_id={self.city_id}, "
                f"target_type_id={self.target_type_id})>")
