#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/number_template/<int:n>', strict_slashes=False)
def display_number_template(n):
    """
    Renders a template called '5-number.html' with the value of the integer parameter passed in the URL.

    Args:
        n (int): The value of the integer parameter passed in the URL.

    Returns:
        str: Rendered HTML template as the response.
    """
    return render_template('5-number.html', n=n)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
