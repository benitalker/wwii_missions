# WWII Missions Analyzer

A Python project for analyzing World War II missions data.

## Description

This project provides tools to analyze and visualize data related to World War II missions. It uses Flask to create a web interface for interacting with the data, and SQLAlchemy for database operations.

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install the required dependencies:

```bash
pip install dictalchemy3 flask toolz returns psycopg2-binary sqlalchemy
```

## Important
dont forget to run the init tables

```python
if __name__ == '__main__':
    create_tables()
    init_tables()
```

## Usage

To run the application:

1. Set up your database and configure the connection in `config.py`.
2. Run the Flask application:

```python
from app import app

if __name__ == '__main__':
    app.run(debug=True)
```

## Features

- Data import and preprocessing
- Mission analysis tools
- Interactive web interface
- Database integration

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Contact

If you have any questions or feedback, please open an issue on this repository.