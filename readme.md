# Bus scheduler with Prolog
## The problem
A company owns 3 buses and employs 5 drivers. Only one
driver can drive any bus on a single day, and each driver cannot work for more than
two consecutive days in a week. The company uses all buses every day.
The task is to make a weekly schedule (7 days) denoting the drivers assigned to
each of the three buses.

## How to Use
This project has been written for [swi prolog](http://www.swi-prolog.org/).First load the knowledge base with
```
[scheduler].
```
command, then use `scheduler` predicament in `scheduler.pl` which will take 3 arguments; a list of names for drivers,
a list of names for buses, schedule to be created(will be the result of the scheduling).
Example;
```
schedule([b1,b2,b3],[d1,d2,d3,d4,d5],[]).
```
Example output;
```
schedule([d1,d2,d3,d4,d5],[b1,b2,b3],[]).
[mon,b1,d1,b2,d2,b3,d3,tue,b1,d1,b2,d2,b3,d3,wed,b1,d4,b2,d5,thu,b1,d1,b2,d2,b3,d3,fri,b1,d1,b2,d2,b3,d3,sat,b1,d4,b2,d5,sun,b1,d1,b2,d2,b3,d3]
true

```
