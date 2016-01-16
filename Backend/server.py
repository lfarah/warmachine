import urllib
from pprint import pprint
import json
import xml.etree.ElementTree as ET
import datetime
from flask import Flask, request, redirect, session, url_for, current_app
import os

app = Flask(__name__)

@app.route('/')
def stepsFinder():
    #call example: http://0.0.0.0:5000/?cLat=47.609219&cLng=-122.425204&dLat=47.520328&dLng=-122.320398
#1. Get steps dic from Google
    cLat = str(request.args['cLat'])
    cLng = str(request.args['cLng'])
    dLat = str(request.args['dLat'])
    dLng = str(request.args['dLng'])

    # cLat = str(47.609219)
    # cLng = str(-122.425204)
    # #destination's location
    # dLat = str(47.520328)
    # dLng = str(-122.320398)
    steps = getStepsFromGoogle(cLat,cLng,dLat,dLng)
#2  Create final array
    final = []

#3. Check if it's raining on each step
    print "loop:"
    for step in steps:

    #4. Get the time of each step
        plusTimes = parseTimes(step,steps)

        stepLoc = step["start_location"]
        lat = stepLoc["lat"]
        lng = stepLoc["lng"]
        print "lat:" + str(lat)
        print "lng" + str(lng)

    #00:00:00
        timeStep = getTimeForStep(step,steps,plusTimes)

        # boolRain = isRaining(lat,lng,timeStep)
        boolRain = True
#5. If it's raining, check for danger
        if boolRain:
            boolDangerous = isDangerous(step)
#6. If it's dangerous, remove step from final
            if boolDangerous:

#7. get alternative legs
                print "Looking for alternatives"
                alternativeLeg = getAlternativeForDanger(step,steps)

#8. Add alternativeLegs to the final
                for aStep in alternativeLeg:
                    final.append(aStep)

            else:
        #5 Add step in final array
                final.append(step)
                print "---adding to final---------"
        else:
            final.append(step)
#9 Print
    print(json.dumps(final))
    return(json.dumps(final))

#Check if its raining on a location on determined time
def isRaining(lat,lng,time):
    time = "80:00:00"
    url = "http://api.weather.com/beta/datacloud/?datatype=forecast&vs=1.0&passkey=d972da81e1ce2f854f9a5560ffb6f243&type=point&var=PrecipIntensity&lat=" + str(lat) + "&lon=" + str(lng) + "&format=hourly&time=now+" + str(time)
    u = urllib.urlopen(url)
    data = u.read()
    split1 = data.split("dbz")[1]
    split2 = split1[2:]
    split3 = split2.split("</P")[0]

    if float(split3)>0:
        print "isRaining"
        return True
    else:
        print "notRaining"
        return False

#Returns accidents.json
def parseJson():
    locations = []
    with open('accidents.json') as data_file:
        data = json.load(data_file)
        for place in data:
            lat = place["Latitude"]
            lng = place["Longitude"]
            danger = place["Danger"]
            dicLoc = {"lat":lat,"lng":lng,"dng":danger}
            locations.append(dicLoc)
    return locations

#Check if step is dangerous
def isDangerous(step):
    delta= 0.001
    stepLoc = step["start_location"]
    lat1 = stepLoc["lat"]
    lng1 = stepLoc["lng"]
    print "start locaton"

    #Getting dangerous areas from accidents.json
    locations = parseJson()

    for danger in locations:

        print (abs(lat1 - danger["lat"]) < delta)
        print (abs(lng1 - danger["lng"]) < delta)
        if ((abs(lat1 - danger["lat"]) < delta) and (abs(lng1 - danger["lng"]) < delta)):
            print "Danger"
            return True
    print "Not dangerous"
    return False

    #If it is raining, check for dangerous areas
    # if isRaining(lat,lng,getTimeForStep(step,steps,plusTimes)):
    #   print("It is raining")

    #   count = 0

                #code chunk1
                # # if locations.index(danger) != len(locations) -1:
                #   # print(locations[locations.index(danger)+1])
                # if steps.index(step) < len(steps)-1:
                #   getAlternativeForDanger(step,steps[steps.index(step)+1],steps,returnDirections)
                #   return
                # else:
                #   step2 = dict(step)
                #   step2["start_location"] = step["end_location"]
                #   getAlternativeForDanger(step,step2,steps,returnDirections)
                #   return

#Give alternative Steps for dangerous step
def getAlternativeForDanger(step,steps):
    #start
    print("alternative")
    stepLoc = step["start_location"]
    sLat = stepLoc["lat"]
    sLng = stepLoc["lng"]

    #Step 2 is the next step
    step2 = {}
    if steps.index(step) < len(steps)-1:
        step2 = steps[steps.index(step)]
    #Last step
    else:
        step2["start_location"] = dict(step["end_location"])

    #End
    stepLoc2 = step2["start_location"]
    eLat = stepLoc2["lat"]
    eLng = stepLoc2["lng"]

    #Alternative
    aLat = eLat + 0.001
    aLng = eLng - 0.001

    url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + str(sLat) + "," + str(sLng) + "&destination=" + str(eLat) + "," + str(eLng) + "&waypoints=" + str(aLat) + "," + str(aLng) + "&mode=driving&sensor=false&alternatives=true&key=AIzaSyCYZCLHpX0Vh9m_OPtDPGAmuiHnl1MsrEk"

    u = urllib.urlopen(url)
    data = u.read()
    routes = json.loads(data)
    # pprint(routes)
    legs = routes["routes"][0]["legs"]
    leg1 = legs[0]["steps"]
    leg2 = legs[1]["steps"]

    leg1.extend(leg2)
    return leg1


    ##Code chunk2
    #replacing first step
    # print("ch")
    # if step in returnDirections:
    #   returnDirections.remove(step)
    # print("ch")

    # index = steps.index(step)
    # for item in leg1:
    #   returnDirections.insert(index,item)
    #   index +=1



    # print("return:")
    # pprint(len(returnDirections))
    # pprint(len(steps))
    # pprint(len(returnDirections))
    # steps[steps.index(step)] = alternateStep

#given step, returns time in 00:00:00 format/
def getTimeForStep(step,steps,plusTimes):
    index = steps.index(step)
    plusTime = plusTimes[index]

    return "00:" + ('%02d' % (plusTime/60)) + ":00"
# @app.route("/")
# def index():
#     return json.dumps(returnDirections)

# @app.route("/getDirections")
# def direct():
    #current location

def parseTimes(step,steps):
    plusTimes = []
    for step in steps:
        currentTime = 0
        currentTime += int(step["duration"]["value"])
        plusTimes.append(currentTime)
    return plusTimes


def getStepsFromGoogle(cLat,cLng,dLat,dLng):
    # print(cLat)
    # print(cLng)
    # print(dLat)
    # print(dLng)

    url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + cLat + "," + cLng + "&destination=" + dLat + "," + dLng + "&mode=driving&sensor=false&alternatives=true"
    # print(url)
    u = urllib.urlopen(url)
    # u is a file-like object
    data = u.read()
    # print(data)
    routes = json.loads(data)

    steps = routes["routes"][0]["legs"][0]["steps"]
    print(json.dumps(steps))
    return steps


#7 Delete dangerous step

    #chunk3
    # print("steps:")
    # pprint(json.dumps(steps))
    # plusTimes = []

    #   if  len(plusTimes) >0:
    #       currentTime = plusTimes[len(plusTimes)-1]

    #   stepLoc = step["start_location"]

    #   checkDanger(step,steps,returnDirections,plusTimes)


# print(json.dumps(returnDirections))
@app.route("/getStepsFromGoogle")
def getGoogle():
    cLat = str(request.args['cLat'])
    cLng = str(request.args['cLng'])
    dLat = str(request.args['dLat'])
    dLng = str(request.args['dLng'])

    url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + cLat + "," + cLng + "&destination=" + dLat + "," + dLng + "&mode=driving&sensor=false&alternatives=true"
    # print(url)
    u = urllib.urlopen(url)
    # u is a file-like object
    data = u.read()
    # print(data)
    routes = json.loads(data)

    steps = routes["routes"][0]["legs"][0]["steps"]
    print(json.dumps(steps))
    return json.dumps(steps)

@app.route("/getDangerLevel")
def getDangerLevel():
    lat = float(request.args['lat'])
    lng = float(request.args['lng'])

    locations = parseJson()

    pprint(locations[0])

    delta= 0.001
    for danger in locations:
        if ((abs(lat - danger["lat"]) < delta) and (abs(lng - danger["lng"]) < delta)):
            return str(danger["dng"])

    return "LALALA"

    #http://weatherway.mybluemix.net/getDangerLevel?lat=47.6135230&lng=-122.3840902

port = os.getenv('VCAP_APP_PORT', '5000')
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(port))