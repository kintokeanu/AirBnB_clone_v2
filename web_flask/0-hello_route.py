#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask

app = Flask(__name__)


@app.get('/')
def root():
    """
    Root path request handler.

    Returns:
        str: The string "Hello HBNB!".
    """
    return 'Hello HBNB!'


if __name__ == '__main__':
    app.run()
