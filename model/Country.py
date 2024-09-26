from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from config.base import Base

class Country(Base):
    __tablename__ = "Countries"

    country_id = Column(Integer, primary_key=True, autoincrement=True)
    country_name = Column(String(100), unique=True, nullable=False)

    cities = relationship("City", back_populates="country")

    def __repr__(self):
        return f"<Country(country_id={self.country_id}, country_name='{self.country_name}')>"
