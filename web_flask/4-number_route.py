#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask

app = Flask(__name__)


@app.route('/number/<int:n>', strict_slashes=False)
def display_number(n):
    """
    Returns a string containing the integer `n` and a message.

    Args:
        n (int): The integer to display in the returned string.

    Returns:
        str: A string containing the integer `n` and a message.
    """
    return "{} is a number".format(n)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
