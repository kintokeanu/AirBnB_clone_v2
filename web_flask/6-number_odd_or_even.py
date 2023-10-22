#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/number_odd_or_even/<int:n>', strict_slashes=False)
def display_number_odd_or_even(n):
    """
    Determines whether a given number is odd or even and renders a template with the number and its odd/even status.

    Args:
        n (int): The number to be checked for odd or even.

    Returns:
        str: Renders the template '6-number_odd_or_even.html' with the number `n` and the string 'odd' or 'even' depending on whether `n` is odd or even.
    """
    if n % 2 == 0:
        odd_or_even = 'even'
    else:
        odd_or_even = 'odd'
    return render_template('6-number_odd_or_even.html', n=n, odd_or_even=odd_or_even)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
