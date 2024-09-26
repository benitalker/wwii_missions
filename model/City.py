from sqlalchemy import Column, Integer, String, ForeignKey, DECIMAL, Sequence
from sqlalchemy.orm import relationship
from config.base import Base

class City(Base):
    __tablename__ = "cities"
    city_id = Column(Integer, Sequence('city_id_seq'), primary_key=True)
    city_name = Column(String(100), unique=True, nullable=False)
    country_id = Column(Integer, ForeignKey('countries.country_id'), nullable=False)  # Adjusted ForeignKey
    latitude = Column(DECIMAL, nullable=True)
    longitude = Column(DECIMAL, nullable=True)

    # Add back_populates to match the other side of the relationship
    country = relationship("Country", back_populates="cities")

    def __repr__(self):
        return (f"<City(city_id={self.city_id}, city_name='{self.city_name}', "
                f"country_id={self.country_id}, latitude={self.latitude}, "
                f"longitude={self.longitude})>")
