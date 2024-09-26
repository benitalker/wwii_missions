from sqlalchemy import Column, Integer, String, Date, Numeric, ForeignKey
from sqlalchemy.orm import relationship
from config.base import Base

class Mission(Base):
    __tablename__ = "mission"

    mission_id = Column(Integer, primary_key=True, autoincrement=True)
    mission_date = Column(Date, nullable=False)
    theater_of_operations = Column(String(100), nullable=False)
    country = Column(String(100), nullable=False)
    air_force = Column(String(100), nullable=False)
    unit_id = Column(String(100), nullable=False)
    mission_type = Column(String(100), nullable=False)
    takeoff_base = Column(String(255), nullable=False)
    takeoff_location = Column(String(255))
    attacking_aircraft = Column(Integer)
    bombing_aircraft = Column(Integer)
    aircraft_returned = Column(Integer)
    aircraft_failed = Column(Integer)

    def __repr__(self):
        return (f"<Mission(mission_id={self.mission_id}, mission_date='{self.mission_date}', "
                f"theater_of_operations='{self.theater_of_operations}', country='{self.country}', "
                f"air_force='{self.air_force}', unit_id='{self.unit_id}', "
                f"aircraft_series='{self.aircraft_series}', callsign='{self.callsign}', "
                f"mission_type='{self.mission_type}', takeoff_base='{self.takeoff_base}', "
                f"attacking_aircraft={self.attacking_aircraft}, bombing_aircraft={self.bombing_aircraft}, "
                f"aircraft_returned={self.aircraft_returned}, aircraft_failed={self.aircraft_failed})>")
