"""Get Play PLay data"""
#
import nflgame
import json

games = nflgame.games(2015, week =17)
# games = nflgame.one(2015, 17, "SF", "STL")
data = games.players
plays = nflgame.combine_plays(games)
for p in plays:
    print p

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
