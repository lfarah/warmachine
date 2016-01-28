"""Get Play PLay data"""
#
import nflgame

games = nflgame.games(2013, week=1)
plays = nflgame.combine_plays(games)
for p in plays.sort('passing_yds').limit(5):
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
