from sqlalchemy import Column, Integer, String, ForeignKey, Numeric
from sqlalchemy.orm import relationship
from config.base import Base

class City(Base):
    __tablename__ = "Cities"

    city_id = Column(Integer, primary_key=True, autoincrement=True)
    city_name = Column(String(100), unique=True, nullable=False)
    country_id = Column(Integer, ForeignKey('Countries.country_id'), nullable=False)
    latitude = Column(Numeric)
    longitude = Column(Numeric)

    country = relationship("Country", back_populates="cities")
    targets = relationship("Target", back_populates="city")

    def __repr__(self):
        return (f"<City(city_id={self.city_id}, city_name='{self.city_name}', "
                f"country_id={self.country_id}, latitude={self.latitude}, "
                f"longitude={self.longitude})>")
