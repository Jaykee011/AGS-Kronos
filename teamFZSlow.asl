/*author: Michaela Dronzekova, xdronz00
*/
position(-1,-1).

+step(0) <- .println("START");?grid_size(A,B);+right(A);+down(B);+down; +right; ?pos(C,D); +firstPos(C,D); +secondPos(C,D); !gov2; .abolish(secondPos(_,_)); +secondPos(C,D).



+!goto(A,B): pos(C,D) & C<A  & not(notRight) <- -left; +right; -notLeft; -notDown; -notUp;  !gov2.
+!goto(A,B): pos(C,D) & C<A & notRight <- !gov2.
+!goto(A,B): pos(C,D) & C > A & not(notLeft) <- -right; +left; -notRight; -notDown; -notUp; !gov2.
+!goto(A,B): pos(C,D) & C > A & notLeft <- !gov2.
+!goto(A,B): pos(C,D) & D < B & not(notDown) <- -up; +down; -notLeft; -notRight; -notUp; !go2.
+!goto(A,B): pos(C,D) & D < B & notDown <-  !go2.
+!goto(A,B): pos(C,D) & D > B & not(notUp) <- -down; +up; -notLeft; -notRight; -notDown; !go2.
+!goto(A,B): pos(C,D) & D > B & notUp<- !go2.


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
+step(X): not(bag_full) &  position(A,B) & pos(A,B) &not(position(-1,-1)) <- -left; +right; -up; +down; .abolish(position(_,_)); .abolish(returnPos(_,_)); +position(-1,-1); !gov2.
+step(X): not(bag_full) &  position(A,B) & not(position(-1,-1)) <- ?position(A,B); !goBack.//!goto(A,B).
+step(X) <- !gov2.

+!goBack: pos(A,B) & returnPos(A+1,B) <- .abolish(returnPos(A+1,B)); do(right).
+!goBack: pos(A,B) & returnPos(A-1,B) <- .abolish(returnPos(A-1,B)); do(left).
+!goBack: pos(A,B) & returnPos(A,B+1) <- .abolish(returnPos(A,B+1)); do(down).
+!goBack: pos(A,B) & returnPos(A,B-1) <- .abolish(returnPos(A,B-1)); do(up).
+!goBack <- !gov2.

 //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

+!canGoRight: pos(A,B) & right(C) & A < C -1 & not wentLeft <- if( not water(A,B) & not stone(A+1,B)){
 													 +canGoR(t);
												}
												elif( water(A,B) & not water(A+1,B) & not stone(A+1, B)){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A, B-1) & B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A, B+1)& B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A+1, B+1) & B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A+1, B-1) & B > 0 & B < C -1){
													+canGoR(t);
												}
												else{
													+canGoR(f);
												}.
+!canGoRight <- +canGoR(f).

+!canGoLeft: pos(A,B) &  A > 0 & not wentRight <- if( not water(A,B) & not stone(A-1,B)){
 													 +canGoL(t);
												}
												elif( water(A,B) & not water(A-1,B) & not stone(A-1,B)){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A, B-1) & B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A, B+1)& B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A-1, B+1) & B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A-1, B-1) & B > 0 & B < C -1){
													+canGoL(t);
												}
												else{
													+canGoL(f);												
												}.
												
+!canGoLeft <- +canGoL(f).

+!canGoDown: pos(A,B) &  down(C) & B < C -1 & not wentUp <- if( not water(A,B) & not stone(A,B+1)){
 													 +canGoD(t);
												}
												elif( water(A,B) & not water(A,B+1) & not stone(A, B+1)){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A-1, B) & A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A+1, B)& A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A+1, B+1) & A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A-1, B+1) & A > 0 & A < C -1){
													+canGoD(t);
												}
												else{
													+canGoD(f);
												}.
+!canGoDown <- +canGoD(f).


+!canGoUp: pos(A,B) &  B > 0 & not wentDown <- if( not water(A,B) & not stone(A,B-1)){
 													 +canGoU(t);
												}
												elif( water(A,B) & not water(A,B-1) & not stone(A,B-1)){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A-1, B) & A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A+1, B)& A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A+1, B-1) & A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A-1, B-1) & A > 0 & A < C -1){
													+canGoU(t);
												}
												else{
													+canGoU(f);
												}.
+!canGoUp <- +canGoU(f).

 //pohyb zlava doprava - zakladny pohyb, ked nenesiem nic v backpacku
 //mozem ist doprava dole
+!gov2: right & down & pos(A,B) & water(A,B) & right(C) & A > C-5 <- -right; +left; do(down). 
+!gov2: right & down & pos(A,B) & water(A,B) & down(C) & B > C-3 <- -down; +up; !gov2.
 
+!gov2: right & down & pos(A,B) & A == 0 & B == 0 <- -wentRight; -wentDown; -wentLeft;-wentUp; do(down).
+!gov2: right & down & pos(A,B) & right(C) & down(D) & A < C -1  <- !canGoRight; ?canGoR(R); if( R == t){
																					.abolish(canGoR(_));
																					-wentLeft;
																					-wentUp;
 																					do(right);
																					
 																				}
																				else{
																					.abolish(canGoR(_));
																					!canGoDown; ?canGoD(R2);
																					if( R2 == t){
																						-wentLeft;
																						-wentUp;
																						.abolish(canGoD(_));
																						do(down);
																					}
																					else{
																						.abolish(canGoD(_));
																						!canGoUp; ?canGoU(R3);
																						if( R3 == t){
																							.abolish(canGoU(_));
																							+wentUp;
																							do(up);
																						}
																						else{
																							.abolish(canGoU(_));
																							+wentLeft;
																							do(left);
																						}
																					}
																				}.
+!gov2: right & down & pos(A,B) & right(C) & A == C -1 & down(D) & B < D -1 <- -right; +left; -wentUp; -wentLeft; -wentDown; -wentRight;  do(down).
+!gov2: right & down & pos(A,B) & right(C) & A == C -1 & down(D) & B == D -1 <- -right; +left; -down; +up; -wentUp; -wentLeft; -wentDown; -wentRight;  do(up).
																				

+!gov2: left & down & pos(A,B) & water(A,B) & right(C) & A < 5 <- -left; +right; do(down). 
+!gov2: left & down & pos(A,B) & water(A,B) & down(C) & B > C-3 <- -down; +up; !gov2.
+!gov2: left & down & pos(A,B) & B == 0 & right(C) & A == C -1 <- -wentRight; -wentDown; -wentLeft;-wentUp; do(down).
+!gov2: left & down & pos(A,B) & right(C) & down(D) & A > 0 <- !canGoLeft; ?canGoL(R); if( R == t){
																					.abolish(canGoL(_));
																					-wentRight;
																					-wentUp;
 																					do(left);
 																				}
																				else{
																					.abolish(canGoL(_));
																					!canGoDown; ?canGoD(R2);
																					if( R2 == t){
																						-wentRight;
																						-wentUp;
																						.abolish(canGoD(_));
																						do(down);
																					}
																					else{
																						.abolish(canGoD(_));
																						!canGoUp; ?canGoU(R3);
																						if( R3 == t){
																							.abolish(canGoU(_));
																							+wentUp;
																							do(up);
																						}
																						else{
																							.abolish(canGoU(_));
																							+wentRight;
																							do(right);
																						}
																					}
																				}.

+!gov2: left & down & pos(A,B) & right(C) & A == 0 & down(D) & B < D -1 <- -left; +right; -wentUp; -wentRight; -wentDown; -wentLeft; do(down).
+!gov2: left & down & pos(A,B) & right(C) & A == 0 & down(D) & B == D -1 <- -left; +right; -down; +up; -wentUp; -wentRight; -wentDown; -wentLeft; do(up).
 

+!gov2: right & up & pos(A,B) & water(A,B) & right(C) & A > C-5 <- -right; +left; do(up). 
+!gov2: right & up & pos(A,B) & water(A,B) & down(C) & B < 3 <- -up; +down; !gov2.
+!gov2: right & up & pos(A,B) & down(D) & B == D -1 & right(C) & A == 0 <- -wentRight; -wentDown; -wentLeft;-wentUp; do(up).
+!gov2: right & up & pos(A,B) & right(C) & down(D) & A < C -1  <- !canGoRight; ?canGoR(R); if( R == t){
																					.abolish(canGoR(_));
																					-wentDown;
																					-wentLeft;
 																					do(right);
 																				}
																				else{
																					.abolish(canGoR(_));
																					!canGoUp; ?canGoU(R2);
																					if( R2 == t){
																						.abolish(canGoU(_));
																						-wentDown;
																						-wentLeft;
																						do(up);
																					}
																					else{
																						.abolish(canGoU(_));
																						!canGoDown; ?canGoD(R3);
																						if( R3 == t){
																							.abolish(canGoD(_));
																							+wentDown;
																							do(down);
																						}
																						else{
																							.abolish(canGoD(_));
																							+wentLeft;
																							do(left);
																						}
																					}
																				}.
+!gov2: right & up & pos(A,B) & right(C) & A == C -1 & down(D) & B > 0 <- -right; +left; -wentLeft; -wentDown; -wentRight; -wentUp; do(up).
+!gov2: right & up & pos(A,B) & right(C) & A == C -1 & down(D) & B == 0 <- -right; +left; +down; -up; -wentLeft; -wentDown; -wentRight; -wentUp; do(down).

+!gov2: left & up & pos(A,B) & water(A,B) & right(C) & A < 5 <- -left; +right; do(up). 
+!gov2: left & up & pos(A,B) & water(A,B) & down(C) & B < 3 <- -up; +down; !gov2.
+!gov2: left & up & pos(A,B) & down(D) & B == D -1 & right(C) & A == C -1 <- -wentRight; -wentDown; -wentLeft;-wentUp; do(up).
+!gov2: left & up & pos(A,B) & right(C) & down(D) & A > 0  <- !canGoLeft; ?canGoL(R); if( R == t){
																					.abolish(canGoL(_));
																					-wentDown;
																					-wentRight;
 																					do(left);
 																				}
																				else{
																					.abolish(canGoL(_));
																					!canGoUp; ?canGoU(R2);
																					if( R2 == t){
																						.abolish(canGoU(_));
																						-wentDown;
																						-wentRight;
																						do(up);
																					}
																					else{
																						.abolish(canGoU(_));
																						!canGoDown; ?canGoD(R3);
																						if( R3 == t){
																							.abolish(canGoD(_));
																							+wentDown;
																							do(down);
																						}
																						else{
																							.abolish(canGoD(_));
																							+wentRight;
																							do(right);
																						}
																					}
																				}.
+!gov2: left & up & pos(A,B) & right(C) & A == 0 & down(D) & B > 0 <- +right; -left; -wentRight; -wentDown; -wentLeft; -wentUp; do(up).
+!gov2: left & up & pos(A,B) & right(C) & A == 0 & down(D) & B == 0 <- +right; -left; +down; -up; -wentRight; -wentDown; -wentLeft; -wentUp; do(down).


//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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
