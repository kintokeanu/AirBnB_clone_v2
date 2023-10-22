#!/usr/bin/python3
"""Start a Flask web application"""
from flask import Flask
from flask import render_template
from models import storage

app = Flask(__name__)


@app.route('/states_list', strict_slashes=False)
def display_states_list():
    """
    Displays an HTML page with a list of all State objects in DBStorage sorted by name (A->Z).
    """
    states = storage.all("State")

    return render_template('7-states_list.html', states=states)


@app.teardown_appcontext
def close_storage(exception):
    """
    Closes the current SQLAlchemy Session.
    """
    storage.close()


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
