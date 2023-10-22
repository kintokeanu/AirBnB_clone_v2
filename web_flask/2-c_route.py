#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask

app = Flask(__name__)


@app.route("/c/<text>", strict_slashes=False)
def c_text(text):
    """
    Returns a string starting with "C " followed by the modified `text`.

    Args:
        text (str): The text parameter extracted from the URL.

    Returns:
        str: A string starting with "C " followed by the modified `text`.
    """
    text = text.replace("_", " ")
    return "C {}".format(text)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
