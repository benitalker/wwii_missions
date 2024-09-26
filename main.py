from model import City, Country, Target, TargetType
from repository.database import create_tables, drop_tables

if __name__ == '__main__':
    create_tables()

    # drop_tables()
