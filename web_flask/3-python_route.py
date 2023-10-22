#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask

app = Flask(__name__)


@app.route('/python/', defaults={'text': 'is cool'})
@app.route('/python/<text>', strict_slashes=False)
def display_python(text):
    """
    Returns a string starting with "Python " followed by the modified `text`.

    Args:
        text (str): The text parameter extracted from the URL.

    Returns:
        str: A string starting with "Python " followed by the modified `text`.
    """
    text = text.replace("_", " ")
    return "Python {}".format(text)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
