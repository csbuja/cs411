
import flask, flask.views
from flask import request, render_template
import os
import json
import logging
from logging.handlers import RotatingFileHandler
from sqlalchemy import create_engine, MetaData 
import settings
from main import Main
from userFavorites import UserFavorites
from recipeDetails import RecipeDetails
from recipeNote import RecipeNote
from favoritesDelete import FavoritesDelete
from favoritesInsert import FavoritesInsert
from messages import Messages
from login import Login
from user import User
from recommender import Recommender
from searchUserAPI import SearchUserAPI
from exploreRecipes import ExploreRecipes

app = flask.Flask(__name__)

# Don't do this!
#app.secret_key = "zeqbkx"

class Root(flask.views.MethodView):
    def get(self):
        mysqlUN = settings.MYSQL_USER
        mysqlPW = settings.MYSQL_PASSWORD
        dbname = settings.MYSQL_DB
        dbhost = settings.MYSQL_HOST

        myDatabase = 'mysql://%(UN)s:%(PW)s@%(host)s/%(name)s?charset=utf8&use_unicode=0' % \
        {'UN': mysqlUN, 'PW': mysqlPW, 'host': dbhost, 'name': dbname} 
        query = "SELECT user_name, profile_image FROM User"
        engine = create_engine(myDatabase, pool_recycle=3600) 
        connection = engine.connect()
        tabledata = engine.execute(query)
        newtabledata = []
        for row in tabledata:
            newtabledata.append(row)
        connection.close()
        return flask.render_template('index.html', tabledata=newtabledata)

app.add_url_rule('/', view_func=Root.as_view('root'))
app.add_url_rule('/favorites', view_func=UserFavorites.as_view('favorites'), methods=["GET"])
app.add_url_rule('/<page>/', view_func=Main.as_view('page'), methods=["GET"])
app.add_url_rule('/recipe/details',view_func=RecipeDetails.as_view('recipeDetails'), methods=["GET"])
app.add_url_rule('/recipe/note',view_func=RecipeNote.as_view('recipeNote'), methods=["PUT"])
app.add_url_rule('/recipe',view_func=FavoritesDelete.as_view('FavoritesDelete'), methods=["DELETE"])
app.add_url_rule('/recipe',view_func=FavoritesInsert.as_view('FavoritesInsert'), methods=["POST"])
app.add_url_rule('/login',view_func=Login.as_view('login'), methods=["GET"])
app.add_url_rule('/register',view_func=User.as_view('user'), methods=["PUT"])
app.add_url_rule('/messages',view_func=Messages.as_view('messages'), methods=["GET"])
app.add_url_rule('/explore/0',view_func=Recommender.as_view('recommender'), methods=["GET"])
app.add_url_rule('/search/user',view_func=SearchUserAPI.as_view('searchUser'), methods=["GET"])
app.add_url_rule('/user',view_func=User.as_view('getuser'), methods=["GET"])
app.add_url_rule('/explore',view_func=ExploreRecipes.as_view('ExploreRecipes'), methods=["GET"])

if __name__ == '__main__':
    formatter = logging.Formatter("[%(asctime)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s")
    handler = RotatingFileHandler('app.log', maxBytes=10000000, backupCount=5)
    handler.setLevel(logging.DEBUG)
    handler.setFormatter(formatter)
    app.logger.addHandler(handler)
    app.run(host="0.0.0.0", port=8080)
