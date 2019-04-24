/*author: Michaela Dronzekova, xdronz00
*/
position(-1,-1).

+step(0) <- .println("START");?grid_size(A,B);+right(A);+down(B);+down; +right; ?pos(C,D); +firstPos(C,D); +secondPos(C,D); !go; .abolish(secondPos(_,_)); +secondPos(C,D).

//----------------------------PRVY POKUS S GOTO------------------------------------------------------------------------------------
/*+!goto(A,B):pos(C,D)&A<C & can_go(left) & not(avoidingObstacle) <- .abolish(can_go(_)); !setCanGo(-1); do(left)  .
+!goto(A,B):pos(C,D)&A<C & not(can_go(left)) & can_go(down)&not(avoidingObstacle) <- .abolish(can_go(_)); !setCanGo(3); do(down).
+!goto(A,B):pos(C,D)&A<C & not(can_go(left)) & can_go(up) &not(avoidingObstacle)<- .abolish(can_go(_)); !setCanGo(2); do(up) .
+!goto(A,B):pos(C,D)&A<C & not(can_go(left)) & can_go(right) <- .abolish(can_go(_)); !setCanGo(0); do(right) .
+!goto(A,B):pos(C,D)&A<C & not(water(C-1,D)) & not(stone(C-1,D))<- .abolish(can_go(_)); !setCanGo(0); do(left).

+!goto(A,B):pos(C,D)&A>C & can_go(right) &not(avoidingObstacle) <-  .abolish(can_go(_)); !setCanGo(-1); do(right).
+!goto(A,B):pos(C,D)&A>C & not(can_go(right)) & can_go(down) &not(avoidingObstacle)<- .abolish(can_go(_)); !setCanGo(3); do(down) .
+!goto(A,B):pos(C,D)&A>C & not(can_go(right)) & can_go(up)&not(avoidingObstacle) <- .abolish(can_go(_)); !setCanGo(2); do(up) .
+!goto(A,B):pos(C,D)&A>C & not(can_go(right)) & can_go(left) <- .abolish(can_go(_)); !setCanGo(1); do(left).
+!goto(A,B):pos(C,D)&A>C & not(water(C+1,D)) & not(stone(C+1,D))<- .abolish(can_go(_)); !setCanGo(1); do(right).

+!goto(A,B):pos(C,D)&B<D & can_go(up) &not(avoidingObstacle) <- .abolish(can_go(_)); !setCanGo(-1); do(up).
+!goto(A,B):pos(C,D)&B<D & not(can_go(up))&not(avoidingObstacle) & can_go(right) <-.abolish(can_go(_)); !setCanGo(0); do(right) .
+!goto(A,B):pos(C,D)&B<D & not(can_go(up)) & can_go(left) &not(avoidingObstacle)<-.abolish(can_go(_)); !setCanGo(1); do(left) .
+!goto(A,B):pos(C,D)&B<D & not(can_go(up)) & can_go(down) <-  .abolish(can_go(_)); !setCanGo(3); do(down).
+!goto(A,B):pos(C,D)&B<D & not(water(C,D-1)) & not(stone(C,D-1))<- .abolish(can_go(_)); !setCanGo(3); do(up).

+!goto(A,B):pos(C,D)&D<B & can_go(down) &not(avoidingObstacle)<- .abolish(can_go(_)); !setCanGo(-1); do(down) .
+!goto(A,B):pos(C,D)&D<B & not(can_go(down)) & can_go(right) &not(avoidingObstacle) <-.abolish(can_go(_)); !setCanGo(0); do(right) .
+!goto(A,B):pos(C,D)&D<B & not(can_go(down)) & can_go(left) &not(avoidingObstacle) <- .abolish(can_go(_)); !setCanGo(1); do(left) .
+!goto(A,B):pos(C,D)&D<B & not(can_go(down)) & can_go(up) <- .abolish(can_go(_)); !setCanGo(2); do(up).
+!goto(A,B):pos(C,D)&D<B & not(water(C,D+1)) & not(stone(C,D+1))<- .abolish(can_go(_)); !setCanGo(2); do(down).
+!goto(A,B): pos(A,B) <- true.

//X == 0 cannot set to left
//X == 1 cannot set to right
//X == 2 cannot set to down
//X == 3 cannot set to up
+!setCanGo(X): X \==0 & not(can_go(left)) & pos(A,B) &not(stone(A-1,B)) &not(water(A-1,B)) <- +can_go(left); !setCanGo(X).
+!setCanGo(X): X \==0 & not(can_go(left)) & pos(A,B) &not(stone(A-1,B)) &water(A,B) & (not(water(A-1,B)) | not(water(A-1, B-1)) | not(water(A-1, B+1))) <- +can_go(left); !setCanGo(X).

+!setCanGo(X): X \==1 & not(can_go(right)) & pos(A,B) &not(stone(A+1,B)) &not(water(A+1,B)) <- +can_go(right); !setCanGo(X).
+!setCanGo(X): X \==1 & not(can_go(right)) & pos(A,B) &not(stone(A+1,B)) &water(A,B) & (not(water(A+1,B)) | not(water(A+1, B-1)) | not(water(A+1, B+1))) <- +can_go(right); !setCanGo(X).

+!setCanGo(X): X \==2 & not(can_go(down)) & pos(A,B) &not(stone(A,B+1)) &not(water(A,B+1)) <- +can_go(down); !setCanGo(X).
+!setCanGo(X): X \==2 & not(can_go(down)) & pos(A,B) &not(stone(A,B+1)) &water(A,B) & (not(water(A,B+1)) | not(water(A-1, B+1)) | not(water(A+1, B+1))) <- +can_go(down); !setCanGo(X).

+!setCanGo(X): X \==3 & not(can_go(up)) & pos(A,B) &not(stone(A,B-1)) &not(water(A,B-1)) <- +can_go(up); !setCanGo(X).
+!setCanGo(X): X \==3 & not(can_go(up)) & pos(A,B) &not(stone(A,B-1)) &water(A,B) & (not(water(A,B-1)) | not(water(A-1, B-1)) | not(water(A+1, B-1))) <- +can_go(up); !setCanGo(X).
+!setCanGo(X) <- true.*/
//-------------------------------------------KONIEC PRVHO POKUSU S GOTO---------------------------------------------------------------------------------------------------------------


+!goto(A,B): pos(C,D) & C<A  & not(notRight) <- -left; +right; -notLeft; -notDown; -notUp;  !go.
+!goto(A,B): pos(C,D) & C<A & notRight <- !go.
+!goto(A,B): pos(C,D) & C > A & not(notLeft) <- -right; +left; -notRight; -notDown; -notUp; !go.
+!goto(A,B): pos(C,D) & C > A & notLeft <- !go.
+!goto(A,B): pos(C,D) & D < B & not(notDown) <- -up; +down; -notLeft; -notRight; -notUp; !go2.
+!goto(A,B): pos(C,D) & D < B & notDown <-  !go2.
+!goto(A,B): pos(C,D) & D > B & not(notUp) <- -down; +up; -notLeft; -notRight; -notDown; !go2.
+!goto(A,B): pos(C,D) & D > B & notUp<- !go2.

/*+!whereToGo: depot(A,B) & pos(C,D) & C<=A & D <= B <- +right; -left; +down; -up.
+!whereToGo: depot(A,B) & pos(C,D) & C<=A & D >= B <- +right; -left; -down; +up.
+!whereToGo: depot(A,B) & pos(C,D) & C>A & D < B <- -right; +left; +down; -up.
+!whereToGo: depot(A,B) & pos(C,D) & C>A & D > B <- -right; +left; -down; +up.*/

+step(X):bag_full & depot(A,B)& pos(A,B)<-drop(all); -left; +right; -up; +down; ?position(C,D).

//+step(X):bag_full & depot(A,B) & pos(A,B) <- -left; +right; -up; +down; drop(all).
+step(X):bag_full & depot(A,B) & pos(C,D) <- +returnPos(C,D); !goto(A,B).
//vodu zatial neberie, lebo by sa pri tom zacyklil

/*+step(X): water(A,B) & pos(A,B)& not(water(A-1,B)) <- do(left).
+step(X): water(A,B) & pos(A,B)& not(water(A+1,B)) <- do(right). 
+step(X): water(A,B) & pos(A,B)& not(water(A,B-1)) <- do(up).
+step(X): water(A,B) & pos(A,B)& not(water(A,B+1)) <- do(down).*/
+step(X): wood(A,B)&pos(A,B) <- .abolish(position(_,_)); +position(A,B); do(pick).
+step(X): gold(A,B)&pos(A,B)<-.abolish(position(_,_)); +position(A,B);do(pick).
+step(X): pergamen(A,B)&pos(A,B)<-.abolish(position(_,_)); +position(A,B);do(pick).
+step(X): spectacles(A,B) & pos(A,B) <- do(pick).
+step(X): stone(A,B)&pos(A+1,B)<- .abolish(position(_,_)); +position(A+1,B); do(dig,e).
+step(X): stone(A,B) & pos(A-1, B) <- .abolish(position(_,_)); +position(A-1,B); do(dig,w).
+step(X): stone(A,B) & pos(A, B+1) <- .abolish(position(_,_)); +position(A,B+1);do(dig,n).
+step(X): stone(A,B) & pos(A, B-1) <- .abolish(position(_,_)); +position(A,B-1);do(dig,s).
+step(X): not(bag_full) &  position(A,B) & pos(A,B) &not(position(-1,-1)) <- -left; +right; -up; +down; .abolish(position(_,_)); .abolish(returnPos(_,_)); +position(-1,-1); !go.
+step(X): not(bag_full) &  position(A,B) & not(position(-1,-1)) <- ?position(A,B); !goBack.//!goto(A,B).
+step(X) <- !go.

+!goBack: pos(A,B) & returnPos(A+1,B) <- .abolish(returnPos(A+1,B)); do(right).
+!goBack: pos(A,B) & returnPos(A-1,B) <- .abolish(returnPos(A-1,B)); do(left).
+!goBack: pos(A,B) & returnPos(A,B+1) <- .abolish(returnPos(A,B+1)); do(down).
+!goBack: pos(A,B) & returnPos(A,B-1) <- .abolish(returnPos(A,B-1)); do(up).
+!goBack <- !go.

 //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 //pohyb zlava doprava - zakladny pohyb, ked nenesiem nic v backpacku
 //mozem ist doprava dole


+!go: right & down & pos(A,B) & water(A,B) & right(C) & A > C-5 <- -right; +left; do(down). 

+!go: right & down & pos(A,B) & right(C) & A < C-1 & not(water(A,B)) &not(stone(A+1,B)) <- do(right).
+!go: right & down & pos(A,B) & right(C) & A < C-1 & water(A,B) & B > 0  & (not(water(A+1,B)) | not(water(A+1, B+1)) | not(water(A+1,B-1))) &
																  not(stone(A+1,B))	<- do(right).
//mozem ist doprava, ale je tam voda, tak idem dole, ak sa da
+!go: right & down & pos(A,B) & right(C) & A < C-1 & down(D) & B < D -1  &not(water(A,B)) &not(stone(A,B+1)) <-  do(down).
+!go: right & down & pos(A,B) & right(C) & A < C-1 & down(D) & B < D -1 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1))) &
																		  not(stone(A,B+1))<- do(down).
//mozem ist doprava, ale neda sa ani dole, tak zmenim smer dolava (ano je to velmi blbe)
+!go: right & down & pos(A,B) & right(C) & A < C-1 & down(D) & B < D -1<- -right; +left; +notRight; do(left).
//nemozem ist doprava, ale mozem ist dole
+!go: right & down & pos(A,B) & right(C) & down(D) & B < D -1  &not(water(A,B)) &not(stone(A,B+1)) <- -right; +left; do(down).
+!go: right & down & pos(A,B) & right(C) & down(D) & B < D -1 &  water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1))) &
																not(stone(A,B+1))<- -right; +left; do(down).
//nemozem ist doprava a nemozem ist dole, lebo tam je voda, tak menim smer dolava
+!go: right & down & pos(A,B) & right(C) & down(D) & B < D -1 <- -right; +left; do(left).
//nemozem ist doprava ani dole, menim smer na hore a dolava
+!go: right & down <- -right; +left; -down; +up; do(skip).


 //osetrenie pripadu, ked som na prvej ploche skoro na konci a uz vo vode
+!go: left & down & pos(A,B) & water(A,B) &  A < 5 <- -left; +right; do(down).
//mozem ist dolava dole
+!go: left & down & pos(A,B) & A > 0 & not(water(A,B)) &not(stone(A-1,B)) <-  do(left).
+!go: left & down & pos(A,B) & A > 0 & B > 0 &water(A,B) & (not(water(A-1,B)) | not(water(A-1, B+1)) | not(water(A-1,B-1))) &
												  not(stone(A-1,B))<-  do(left).
//mozem ist dolava, ale je tam voda, tak idem dole, ak sa da
+!go: left & down & pos(A,B) & A > 0 & down(D) & B < D -1  &not(water(A,B)) &not(stone(A,B+1))<-   do(down).
+!go: left & down & pos(A,B) & A > 0 & down(D) & B < D -1 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1))) &
															not(stone(A,B+1))<- do(down).
//mozem ist dolava, ale neda sa ani dole, tak zmenim smer doprava
+!go: left & down & pos(A,B) & A > 0 & down(D) & B < D -1<- -left; +right; +notLeft; do(right).
//nemozem ist dolava, ale mozem ist dole
+!go: left & down & pos(A,B) & right(C) & down(D) & B < D -1  &not(water(A,B)) &not(stone(A,B+1)) <- -left; +right; do(down).
+!go: left & down & pos(A,B) & right(C) & down(D) & B < D -1 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1)))&
															   not(stone(A,B+1))<- -left; +right; do(down).
//nemozem ist dolava a nemozem ist dole, lebo tam je voda, tak menim smer doprava
+!go: left & down & pos(A,B) & right(C) & down(D) & B < D -1 <- -left; +right; do(right).
//nemozem ist dolava ani dole, menim smer na hore a doprava
+!go: left & down <- -left; +right; -down; +up; do(skip).


 //osetrenie pripadu, ked som na prvej ploche skoro na konci a uz vo vode
+!go: right & up & pos(A,B) & water(A,B) & right(C) & A > C-5 <- -right; +left;  do(up).
 //mozem ist doprava hore
+!go: right & up & pos(A,B) & right(C) & A < C-1 & not(water(A,B)) &not(stone(A+1,B))<- do(right).
+!go: right & up & pos(A,B) & right(C) & A < C-1 & water(A,B) & down(D) & B < D -1 & water(A,B) & (not(water(A+1,B)) | not(water(A+1, B+1)) | not(water(A+1,B-1))) &
																not(stone(A+1,B)) <- do(right).
//mozem ist doprava, ale je tam voda, tak idem hore, ak sa da
+!go: right & up & pos(A,B) & right(C) & A < C-1 & B > 0  &not(water(A,B)) &not(stone(A,B-1))<-   do(up).
+!go: right & up & pos(A,B) & right(C) & A < C-1 & B > 0 & water(A,B) & (not(water(A,B-1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
														   not(stone(A,B+1))<-  do(up).
//mozem ist doprava, ale neda sa ani hore, tak zmenim smer dolava (ano je to velmi blbe)
+!go: right & up & pos(A,B) & right(C) & A < C-1 & B > 0<- -right; +left; +notRight; do(left).
//nemozem ist doprava, ale mozem ist hore
+!go: right & up & pos(A,B) & right(C) & B > 0 &not(water(A,B)) &not(stone(A,B-1))<- -right; +left; do(up).
+!go: right & up & pos(A,B) & right(C) & B > 0 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
												 not(stone(A,B+1))<- -right; +left;  do(up).
//nemozem ist doprava a nemozem ist hore, lebo tam je voda, tak menim smer dolava
+!go: right & up & pos(A,B) & right(C) & B > 0 <- -right; +left;  do(left).
//nemozem ist doprava ani hore, menim smer na hore a dolava
+!go: right & up <- -right; +left; -up; +down; do(skip).


 //osetrenie pripadu, ked som na prvej ploche skoro na konci a uz vo vode
+!go: left & up & pos(A,B) & water(A,B) &  A < 5 <- -left; +right; do(up).
//mozem ist dolava hore
+!go: left & up & pos(A,B) & A > 0 & not(water(A,B)) &not(stone(A-1,B))<- do(left).
+!go: left & up & pos(A,B) & A > 0 & down(D) & B < D -1 & water(A,B) & (not(water(A-1,B)) | not(water(A-1, B+1)) | not(water(A-1,B-1))) &
												  not(stone(A-1,B)) <-  do(left).
//mozem ist dolava, ale je tam voda, tak idem hore, ak sa da
+!go: left & up & pos(A,B) & A > 0 &  B > 0  &not(water(A,B)) &not(stone(A,B-1))<-  do(up).
+!go: left & up & pos(A,B) & A > 0 & B > 0 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
											 not(stone(A,B+1))	<- do(up).
//mozem ist dolava, ale neda sa ani hore, tak zmenim smer doprava
+!go: left & up & pos(A,B) & A > 0 & B > 0<- -left; +right; +notLeft; do(right).
//nemozem ist dolava, ale mozem ist hore
+!go: left & up & pos(A,B) & right(C) & B > 0  &not(water(A,B)) &not(stone(A,B-1))<- -left; +right;  do(up).
+!go: left & up & pos(A,B) & right(C) & B > 0 & water(A,B) & (not(water(A,B-1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
												not(stone(A,B+1)) <- -left; +right; do(up).
//nemozem ist dolava a nemozem ist hore, lebo tam je voda, tak menim smer doprava
+!go: left & up & pos(A,B) & right(C) & B > 0 <- -left; +right; +notLeft;  do(right).
//nemozem ist dolava ani dole, menim smer na dole a dolava
+!go: left & up <- -left; +right; +down; -up; do(skip).
+!go <- do(skip).




//pohyb zhora nadol - pohyb, ked sa snazim dostat do depotu a vyhnut sa prekazkam
+!go2: right & down & pos(A,B) & down(C) & B < C-1 & not(water(A,B)) &not(stone(A,B+1)) <-  do(down).
+!go2: right & down & pos(A,B) & down(C) & B < C-1 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1))) &
																  not(stone(A,B+1)) <-  do(down).
+!go2: right & down & pos(A,B) & down(C) & B < C-1 & right(D) & A < D -1  &not(water(A,B)) &not(stone(A+1,B)) <- +notLeft;  do(right).
+!go2: right & down & pos(A,B) & down(C) & B < C-1 & right(D) & A < D -1 & water(A,B) &  (not(water(A+1,B)) | not(water(A+1, B-1)) | not(water(A+1,B+1))) &
																		   not(stone(A+1,B)) <- +notLeft;  do(right).
+!go2: right & down & pos(A,B) & down(C) & B < C-1 & right(D) & A < D -1<- +notRight; do(left).
+!go2: right & down & pos(A,B) & right(C) & right(D) & A < D -1  &not(water(A,B)) &not(stone(A+1,B))<- -down; +up; do(right).
+!go2: right & down & pos(A,B) & right(C) & right(D) & A < D -1 & water(A,B) & (not(water(A+1,B)) | not(water(A+1, B-1)) | not(water(A+1,B+1))) &
																  not(stone(A+1,B)) <- -down; +up;  do(right).
+!go2: right & down & pos(A,B) & right(C) & right(D) & A < D -1 <- -down; +up;  do(up).
+!go2: right & down <- -right; +left; -down; +up; do(skip).

+!go2: left & down & pos(A,B) & down(C) & B < C-1 & not(water(A,B)) &not(stone(A,B+1))<- do(down).
+!go2: left & down & pos(A,B) & down(C) & B < C-1 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B+1)) | not(water(A-1,B+1))) &
																 not(stone(A,B+1)) <-  do(down).
+!go2: left & down & pos(A,B) & down(C) & B < C-1 & right(D) & A > 0  &not(water(A,B)) &not(stone(A-1,B))<- +notRight;  do(left).
+!go2: left & down & pos(A,B) & down(C) & B < C-1 & right(D) & A > 0 & water(A,B) & (not(water(A-1,B)) | not(water(A-1, B-1)) | not(water(A-1,B+1))) <- +notRight; do(left).
+!go2: left & down & pos(A,B) & down(C) & B < C-1 & right(D) & A > 0<- +notLeft;  do(right).
+!go2: left & down & pos(A,B) & right(C) & right(D) & A > 0  &not(water(A,B)) &not(stone(A-1,B))<- -down; +up;  do(left).
+!go2: left & down & pos(A,B) & right(C) & right(D) & A > 0 & water(A,B) & (not(water(A-1,B)) | not(water(A-1, B-1)) | not(water(A-1,B+1))) &
															  not(stone(A-1,B)) <- -down; +up; do(left).
+!go2: left & down & pos(A,B) & right(C) & right(D) & A > 0 <- -down; +up;  do(up).
+!go2: left & down <- -left; +right; -down; +up; do(skip).

+!go2: right & up & pos(A,B) & B > 0 & not(water(A,B)) &not(stone(A,B-1))<- do(up).
+!go2: right & up & pos(A,B) & B > 0 & water(A,B) & (not(water(A,B-1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
													not(stone(A,B-1)) <-  do(up).
+!go2: right & up & pos(A,B) & B > 0 & right(D) & A < D -1  &not(water(A,B)) &not(stone(A+1,B))<- +notLeft;  do(right).
+!go2: right & up & pos(A,B) & B > 0 & right(D) & A < D -1 & water(A,B) & (not(water(A+1,B)) | not(water(A+1, B-1)) | not(water(A+1,B+1))) &
															 not(stone(A+1,B))	<-  +notLeft;  do(right).
+!go2: right & up & pos(A,B) & B > 0 & right(D) & A < D -1<-  +notRight;  do(left).
+!go2: right & up & pos(A,B) & right(C) & right(D) & A < D -1  &not(water(A,B)) &not(stone(A+1,B)) <- -up; +down; do(right).
+!go2: right & up & pos(A,B) & right(C) & right(D) & A < D -1 &water(A,B) &  (not(water(A+1,B)) | not(water(A+1, B-1)) | not(water(A+1,B+1))) &
																not(stone(A+1,B)) <- -up; +down;  do(right).
+!go2: right & up & pos(A,B) & right(C) & right(D) & A < D -1 <- -up; +down;  do(down).
+!go2: right & up <- -right; +left; -up; +down; do(skip).

+!go2: left & up & pos(A,B) & B > 0 & not(water(A,B)) &not(stone(A,B-1))<- do(up).
+!go2: left & up & pos(A,B) & B > 0 & water(A,B) & (not(water(A,B+1)) | not(water(A+1, B-1)) | not(water(A-1,B-1))) &
												   not(stone(A,B+1)) <- do(up).
+!go2: left & up & pos(A,B) & B > 0 & right(D) & A > 0  &not(water(A,B)) &not(stone(A-1,B))<- +notRight; do(left).
+!go2: left & up & pos(A,B) & B > 0 & right(D) & A > 0 & water(A,B) &  (not(water(A-1,B)) | not(water(A-1, B-1)) | not(water(A-1,B+1))) &
														 not(stone(A-1,B))	<- +notRight;  do(left).
+!go2: left & up & pos(A,B) & B > 0 & right(D) & A > 0<- +notLeft; do(right).
+!go2: left & up & pos(A,B) & right(C) & right(D) & A > 0  &not(water(A,B)) &not(stone(A-1,B))<- -up; +down; do(left).
+!go2: left & up & pos(A,B) & right(C) & right(D) & A > 0 & water(A,B) & (not(water(A-1,B)) | not(water(A-1, B-1)) | not(water(A-1,B+1))) &
															not(stone(A-1,B)) <- -up; +down;  do(left).
+!go2: left & up & pos(A,B) & right(C) & right(D) & A > 0 <- -up; +down;  do(down).
+!go2: left & up <- -left; +right; -up; +down; do(skip).
+!go2 <- do(skip).
