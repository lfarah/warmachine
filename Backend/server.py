import urllib
from pprint import pprint
import json
import xml.etree.ElementTree as ET
import datetime
from flask import Flask, request, redirect, session, url_for, current_app
import os

app = Flask(__name__)


# print(json.dumps(returnDirections))
# @app.route("/")
# def getGoogle():
    # cLat = str(request.args['cLat'])
    # cLng = str(request.args['cLng'])
    # dLat = str(request.args['dLat'])
    # dLng = str(request.args['dLng'])

with open('game.json') as data_file:
    data = json.load(data_file)
    #pprint(data["gamepackageJSON"]["drives"]["previous"][0]["plays"])

    index = 5
    arrToReturnPlay = []
    for drive in data["gamepackageJSON"]["drives"]["previous"]:
        arrToReturn = []
        for play in drive["plays"]:
            print "team: "
            team = data["gamepackageJSON"]["drives"]["previous"][index]["team"]["displayName"]
            pprint(team)

            print("description: ")
            description = play["text"]
            pprint(description)
            print("------------")

            print("home: ")
            homeScore = play["homeScore"]
            pprint(homeScore)

            print("away: ")
            awayScore = play["awayScore"]
            pprint(awayScore)
            print("------------")

            print("type: ")
            playType = play["type"]["text"]
            pprint(playType)

            print("yardline: ")
            yardLine = play["start"]["yardLine"]
            pprint(yardLine)

            print("down: ")
            down = play["start"]["down"]
            pprint(down)

            print("time: ")
            time = play["clock"]["displayValue"]
            pprint(time)
            print("------------ // -------------")

            arrToReturn.append({'team': team,
                       'description': description,
                       'homeScore': homeScore,
                       'awayScore': awayScore,
                       'playType': playType,
                       'yardLine': yardLine,
                       'down': down,                   
                       'time': time})
            arrToReturnPlay.append(arrToReturn)
    pprint(json.dumps(arrToReturnPlay))

    # url = "http://api.sportradar.us/nfl-sim-t1/2013/REG/18/CHI/MIN/pbp.xml?api_key=zw3392skmuzrhdhn885f8869"
    # # # print(url)
    # u = urllib.urlopen(url)
    # # # u is a file-like object
    # data = u.read()
    # print(type(data))
    # routes = json.loads(data)

    # steps = routes["routes"][0]["legs"][0]["steps"]
    # print(json.dumps(steps))
    #return type(data)

# port = os.getenv('VCAP_APP_PORT', '5000')
# if __name__ == "__main__":
#     app.run(host='0.0.0.0', port=int(port))