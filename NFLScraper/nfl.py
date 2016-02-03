"""Get Play PLay data"""
#
import nflgame
import pprint

games = nflgame.games(2013,10)
my_game = games[0:1]
plays = nflgame.combine_plays(my_game)
my_play = []
for p in plays.limit(10000):
    my_play.append(p)
    # print p.time
    print "%s %s" (p.time, p.yardline)
    # print p._call_
    # print dir(p())
    # print p.type()
    # print p.id()
    # print p.locals()

# print my_play
# for p in plays.limit(10000):
#     print p

# with open('nfl.json', 'w') as outfile:
#     json.dump(data, outfile)





# import nfldb
# import nflvid.vlc
#
# db = nfldb.connect()
# q = nfldb.Query(db)
#
# q.game(season_year=2012, season_type='Regular')
# q.player(full_name='Adrian Peterson').play(rushing_yds__ge=50)
#
# nflvid.vlc.watch(db, q.as_plays(), '/m/nfl/coach/pbp')
