// Agent aDruid in project jasonTeam.mas2j

/* Initial beliefs and rules */

/* Initial goals */

!start.

+step(X):depot(pergamen,Y)&Y>3<-do(read,4).
+step(X):spell(A,B,C,D)<-do(create,A,B,C,D).


/* Plans */

+!start : true <- .print("hello world.").

