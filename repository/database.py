from config.base import engine, Base

def create_tables():
    tables_to_create = [table for name, table in Base.metadata.tables.items() if name != 'mission']
    Base.metadata.create_all(engine, tables=tables_to_create)
    print("tables created (excluding Mission)")

def drop_tables():
    tables_to_drop = [table for name, table in Base.metadata.tables.items() if name != 'mission']
    Base.metadata.drop_all(engine, tables=tables_to_drop)
    print("tables dropped (excluding Mission)")
