from config.base import engine, Base

def create_tables():
    Base.metadata.create_all(engine)
    print("tables created")

def drop_tables():
    Base.metadata.drop_all(engine)
    print("tables dropped")
