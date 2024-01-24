from flask import Flask, render_template
from flask_cors import CORS
from flask_assets import Environment
from kube import get_stats

from config import Config

app = Flask(__name__)
CORS(app)
app.config.from_object(Config)

assets = Environment(app)
assets.url = app.static_url_path


@app.route("/", methods=["GET"])
def home():
    """
    Home page route
    """
    kube_stats = get_stats()
    return render_template("index.html", **kube_stats)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
