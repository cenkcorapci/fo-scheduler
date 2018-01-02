is_day(mon).
is_day(tue).
is_day(wed).
is_day(thu).
is_day(fri).
is_day(sat).
is_day(sun).


%Check if assigned in last n days%
scheduled_in_last_n_days(Driver, [Item|_], N) :-
  N >= 0,
  Item = Driver.

scheduled_in_last_n_days(Driver, [Item|ReversedSchedule], N) :-
  N >= 0,
  is_day(Item),
  Y is N - 1,
  scheduled_in_last_n_days(Driver, ReversedSchedule, Y).

scheduled_in_last_n_days(Driver, [Item|ReversedSchedule], N) :-
  N >= 0,
  Item \= Driver,
  \+ is_day(Item),
  scheduled_in_last_n_days(Driver, ReversedSchedule, N).

% Schedule %
scheduler(Buses, AllBuses, Drivers, AllDrivers, [Day|Days], X) :-
  % scheduling next day if all the buses have been assigned %
  length(Buses, BusesLeft),
  length(Drivers, DriversLeft),
  (BusesLeft = 0; DriversLeft = 0),
  append(X, [Day], Acc),
  scheduler(AllBuses, AllBuses, AllDrivers, AllDrivers, Days, Acc).

% assign driver if it's feasible %
scheduler([Bus|Buses],  AllBuses, [Driver|DriversLeft],Drivers, Days, X) :-
  reverse(X, R),
  \+ scheduled_in_last_n_days(Driver, R, 2),
  append(X, [Bus, Driver], Y),
  scheduler(Buses, AllBuses, DriversLeft, Drivers, Days, Y).

scheduler(Buses,  AllBuses, [_|DriversLeft], Drivers, Days, X) :-
  scheduler(Buses, AllBuses, DriversLeft, Drivers, Days, X).

scheduler(_, _,  DriversLeft, _, DaysLeft, X) :-
  % Done if all of the days have been assigned %
  length(DriversLeft, Dr),
  length(DaysLeft, Da),
  Dr = 0,
  Da = 0,
  write(X),
  nl.

% Call scheduler %
schedule(Buses, Drivers, _) :-
  scheduler([], Buses, [], Drivers, [mon, tue, wed, thu, fri, sat, sun], []).
