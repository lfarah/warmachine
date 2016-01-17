import urllib
from pprint import pprint
import json
import xml.etree.ElementTree as ET
import datetime
from flask import Flask, request, redirect, session, url_for, current_app
import os
import re
app = Flask(__name__)


# print(json.dumps(returnDirections))
# @app.route("/")
# def getGoogle():
    # cLat = str(request.args['cLat'])
    # cLng = str(request.args['cLng'])
    # dLat = str(request.args['dLat'])
    # dLng = str(request.args['dLng'])

#-------- IMPORTANT WORD ------ #

def cleanDescription(description):
    name = findName(description)
    cleanDescription = ""
    description = description.replace("(","")
    description = description.replace(")","")
    description = description.replace(";","")
    description = description.replace(name,"")
    words = description.split(" ")
    #print("clean: " + description)

    for word in words:
        if name != word and word != "NE" and word != "CAR" and word != "yard" and word != "-1" and word != "yards":
            cleanDescription += " " + word
    return cleanDescription

def getImportantWord(description):
    firstCleanDescription = cleanDescription(description)
    cleanerDescription = cleanDescription(firstCleanDescription)
    cleanestDescription = cleanDescription(cleanerDescription)
    fuckingCleanDescription = cleanDescription(cleanestDescription)
    print(fuckingCleanDescription)
    url = "http://gateway-a.watsonplatform.net/calls/text/TextGetRankedKeywords?apikey=0620a9cb4350967fa7abf33eace24882b05ca422&sentiment=0&outputMode=json&text=" + fuckingCleanDescription
    u = urllib.urlopen(url)
     # # u is a file-like object
    data = u.read()
    jsonFile = json.loads(data)

    if jsonFile["status"] != "ERROR":
        if len(jsonFile["keywords"])>0:
            keyword = jsonFile["keywords"][0]["text"]
            return keyword
    return ""

#-------- NAME FINDER --------- #
def findName(description):
    compiled_regex = re.compile('([A-Z].[A-Z][a-z]+)')
    arrayNames = compiled_regex.findall(description)
    if len(arrayNames)>0:
        return arrayNames[0]
    else:
        return ""

# ------- CLEAN GAME ---------- #
with open('game.json') as data_file:
    data = json.load(data_file)
    #pprint(data["gamepackageJSON"]["drives"]["previous"][0]["plays"])

    #index = 5
    arrToReturnPlay = []
    for drive in data["gamepackageJSON"]["drives"]["previous"]:
        arrToReturn = []
        team = drive["team"]["abbreviation"]
        #pprint(team)
        for play in drive["plays"]:
            #print "team: "
            #print("description: ")
            description = play["text"]
            #pprint(description)

            # print("player: ")
            # player = findName(description)
            # pprint(player)
            # print("------------")

            # print("home: ")
            # homeScore = play["homeScore"]
            # pprint(homeScore)

            # print("away: ")
            # awayScore = play["awayScore"]
            # pprint(awayScore)
            # print("------------")

            # print("type: ")
            # playType = play["type"]["text"]
            # pprint(playType)

            # print("yardline: ")
            # yardLine = play["start"]["yardLine"]
            # pprint(yardLine)

            # print("yardsToEndzone: ")
            # yardsToEndzone = play["start"]["yardsToEndzone"]
            # pprint(yardsToEndzone)

            # print("distance: ")
            # distance = play["start"]["distance"]
            # pprint(distance)

            # print("down: ")
            # down = play["start"]["down"]
            # pprint(down)

            # print("time: ")
            # time = play["clock"]["displayValue"]
            # pprint(time)

            #print("importantWord: ")
            importantWord = getImportantWord(description)
            pprint(importantWord)
            #print("------------ // -------------")

    #         arrToReturn.append({'team': team,
    #                    'description': description,
    #                    'player': player,                   
    #                    'homeScore': homeScore,
    #                    'awayScore': awayScore,
    #                    'playType': playType,
    #                    'yardLine': yardLine,                       
    #                    'yardsToEndzone': yardsToEndzone,
    #                    'distance': distance,
    #                    'down': down,                   
    #                    'time': time,
    #                    'importantWord': importantWord})
    #         arrToReturnPlay.append(arrToReturn)
    # pprint(json.dumps(arrToReturnPlay))

    #-------------//------------#

    

# port = os.getenv('VCAP_APP_PORT', '5000')
# if __name__ == "__main__":
#     app.run(host='0.0.0.0', port=int(port))