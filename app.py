from flask import Flask, render_template, request

app = Flask(
  __name__,
  template_folder='templates',
  static_folder='static'
)

photos = {
  "crocs": {"filename": "crocodiles.png",
    "caption": "Crocodiles just chilling in the river below me.",
    "year": "2012",
    "location": "Costa Rica"
  },
  "lorakeets": {"filename": "lorakeets.png",
    "caption": "Lorakeets eating breakfast outside my window.",
    "year": "2010",
    "location": "Australia"
  },
  "spider": {"filename": "spider.png",
    "caption": "A rather large spider spinning a web.",
    "year": "2011",
    "location": "Australia"
  }
}

@app.route('/')
def index():

  return render_template('index.html', photos=photos)

@app.route('/order')
def order():
  return render_template('order.html', photo=photos.get(request.args.get('photo_id')))

@app.errorhandler(404)
def handle_404(e):
    return render_template('404.html')

if __name__ == '__main__':
  app.run(host='0.0.0.0')