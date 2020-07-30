Ancestry tree

Collections #=> Top super class

CSV_classes: Games, Game_teams, Teams #=> child to Collections.

Season_statistics #=> Helper methods. child to CSV_classes  Parent to stat_tracker.

stat_tracker #=> child to Season_statistics.


Ancestry tree 2

Collections #=> Top super class

CSV_classes: Games, Game_teams, Teams #=> child to Collections.

stat_tracker #=> child to Season_statistics. |||| Season_statistics #=> Helper methods. child to CSV_classes  Parent to stat_tracker.