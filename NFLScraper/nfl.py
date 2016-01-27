import nflgame

games = nflgame.games(2015, week = 10 )
plays = nflgame.combine_plays(games)
for p in plays.sort('passing_yds').limit(5):
    print p
# db = nfldb.connect()
# q = nfldb.Query(db)
#
# q.game(season_year=2012, season_type='Regular')
# for pp in q.sort('passing_yds').limit(10).as_aggregate():
#     print pp.player, pp.passing_yds
