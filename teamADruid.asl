// Agent aDruid in project jasonTeam.mas2j



/* Initial beliefs and rules */



/* Initial goals */



!start.
+step(X):depot(pergamen,Y) & Y>=5 <- do(read,5).
+step(X):depot(pergamen,Y) & Y>=4 & money(us,V) & money(them,Z) & V >= 40 & Z > V <- do(read,4).
+step(X):depot(pergamen,Y) & Y>=3 & money(us,V) & money(them,Z) & V >= 70 & Z > V <- do(read,3).
+step(X):depot(pergamen,Y) & Y>=4 & money(us,V) & money(them,Z) & V >= 55 & Z < V <- do(read,4).
+step(X):depot(pergamen,Y) & Y>=3 & money(us,V) & money(them,Z) & V >= 80 & Z < V <- do(read,3).
+step(X):depot(pergamen,Y) & Y>=3 & money(us,V) & money(them,Z) & V >= 80 & Z == V <- do(read,3).
+step(X):spell(A,B,C,D) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & depot(wood,V) & Z >= A & Y>=B & W>=C & V >=D & (A+B+C+D) >= 5 <- do(create,A,B,C,D).
+step(X):spell(A,B,C,D) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & depot(wood,V) & Z >= A & Y>=B & W>=C & V >=D & (A+B+C+D) >= 4 <- do(create,A,B,C,D).
+step(X):spell(A,B,C,D) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & depot(wood,V) & Z >= A & Y>=B & W>=C & V >=D & (A+B+C+D) >= 3 <- do(create,A,B,C,D).
+step(X):spell(A,B,C,D) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & depot(wood,V) & Z >= A & Y>=B & W>=C & V >=D <- do(create,A,B,C,D).
+step(X) <- do(skip).


//+step(X) <- !inform.


/* Plans */

/*
+!inform: !spell(A,B,C,D) & depot(wood,X) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & (A+B+C+D == 5) <- 
	.send(aSlow,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aMiddle,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aFast,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold).

+!inform: !spell(A,B,C,D) & depot(wood,X) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & (A+B+C+D == 4) <- 
	.send(aSlow,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aMiddle,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aFast,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold).

+!inform: !spell(A,B,C,D) & depot(wood,X) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & (A+B+C+D == 3) <- 
	.send(aSlow,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aMiddle,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aFast,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold).

+!inform: !spell(A,B,C,D) & depot(wood,X) & depot(stone,Z) & depot(water,Y) & depot(gold,W) & (A+B+C+D == 2) <- 
	.send(aSlow,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aMiddle,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold); 
	.send(aFast,tell,i need A-X woods, B-Z stone, C-Y water, D-W gold).
*/
+!start : true <- .print("START.").
