from sqlalchemy import Column, Integer, String
from config.base import Base

class Country(Base):
    __tablename__ = "Countries"

    country_id = Column(Integer, primary_key=True, autoincrement=True)
    country_name = Column(String(100), unique=True,nullable=False)

    def __repr__(self):
        return f"<Country(country_id={self.country_id}, country_name={self.country_name})>"
