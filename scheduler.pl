is_day(mon).
is_day(tue).
is_day(wed).
is_day(thu).
is_day(fri).
is_day(sat).
is_day(sun).

% Utilities %
removehead([_|Tail], Tail).
first([F|_], F).

% Check if we can select the driver %
working_for_n_consecutive_days(_, _, NLeft, N, Working) :-
  NLeft = 0,
  Working = N.

working_for_n_consecutive_days(Driver, [Item|ReversedSchedule], NLeft, N, Working) :-
  NLeft > 0,
  Item = Driver,
  W is Working + 1,
  working_for_n_consecutive_days(Driver, ReversedSchedule, NLeft, N, W).

working_for_n_consecutive_days(Driver, [Item|ReversedSchedule], NLeft, N, Working) :-
  NLeft > 0,
  is_day(Item),
  L is NLeft - 1,
  working_for_n_consecutive_days(Driver, ReversedSchedule, L, N, Working).

working_for_n_consecutive_days(Driver, [Item|ReversedSchedule], NLeft, N, Working) :-
  NLeft > 0,
  Item \= Driver,
  \+ is_day(Item),
  working_for_n_consecutive_days(Driver, ReversedSchedule, NLeft, N, Working).

driver_is_not_available(Driver, Schedule) :-
  N is 2,
  reverse(Schedule, R),
  first(R, D),
  is_day(D),
  removehead(R, T),
  working_for_n_consecutive_days(Driver, T, N, N, 0).


driver_is_not_available(Driver, Schedule) :-
  N is 2,
  reverse(Schedule, R),
  first(R, D),
  \+ is_day(D),
  working_for_n_consecutive_days(Driver, R, N, N, 0).


% Schedule %
scheduler(Buses, AllBuses, Drivers, AllDrivers, [Day|Days], X) :-
  % scheduling next day if all the buses have been assigned %
  length(Buses, BusesLeft),
  length(Drivers, DriversLeft),
  (BusesLeft = 0; DriversLeft = 0),
  append(X, [Day], Acc),
  scheduler(AllBuses, AllBuses, AllDrivers, AllDrivers, Days, Acc).

% assign driver if it's feasible %
scheduler([Bus|Buses],  AllBuses, [Driver|DriversLeft], Drivers, Days, X) :-
  length(Days, DL),
  DayCount is 7 - DL,
  DayCount >= 3,
  \+ driver_is_not_available(Driver, X),
  append(X, [Bus, Driver], Y),
  scheduler(Buses, AllBuses, DriversLeft, Drivers, Days, Y).

% assign driver if it's feasible %
scheduler([Bus|Buses],  AllBuses, [Driver|DriversLeft], Drivers, Days, X) :-
  length(Days, DL),
  DayCount is 7 - DL,
  DayCount < 3,
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
schedule(Drivers, Buses , _) :-
  scheduler([], Buses, [], Drivers, [mon, tue, wed, thu, fri, sat, sun], []).
