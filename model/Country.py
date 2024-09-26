from sqlalchemy import Column, Integer, String, Sequence
from sqlalchemy.orm import relationship
from config.base import Base

class Country(Base):
    __tablename__ = "countries"
    country_id = Column(Integer, Sequence('country_id_seq'), primary_key=True)
    country_name = Column(String(100), unique=True, nullable=False)

    cities = relationship("City", back_populates="country")

    def __repr__(self):
        return f"<Country(country_id={self.country_id}, country_name='{self.country_name}')>"
