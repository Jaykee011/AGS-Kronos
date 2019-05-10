/*author: Michaela Dronzekova, xdronz00
*/
position(-1,-1).

   +!clearlast <- -lastleft; -lastright; -lastup; -lastdown.
    +!clearforbidden <- -notup; -notdown; -notleft; -notright.
    +!checkWaterUp <- ?pos(A,B); if (water(A,B)&water(A+1,B-1)&water(A,B-1)&water(A-1,B-1)) {+boolean} else {-boolean}.
    +!checkWaterDown <- ?pos(A,B); if (water(A,B)&water(A+1,B+1)&water(A-1,B+1)&water(A,B+1)) {+boolean} else {-boolean}.
    +!checkWaterLeft <- ?pos(A,B); if (water(A,B)&water(A-1,B)&((water(A-1,B+1)|B==0)&(water(A-1,B-1)|B==54))) {+boolean} else {-boolean}.
    +!checkWaterRight <- ?pos(A,B); if (water(A,B)&water(A+1,B)&((water(A+1,B+1)|B==0)&(water(A+1,B-1)|B==54))) {+boolean} else {-boolean}.



+step(0) <- .println("START");?grid_size(A,B);+right(A);+down(B);+down; +right; ?pos(C,D); +firstPos(C,D); +secondPos(C,D); !gov2; do(skip).


 +!goto(X,Y): (stone(X,Y) | pos(X,Y)) <-    +right; -left; -down; -up; !clearforbidden; !clearlast; 
 													-goBack;
													
                                                    do(skip); do(skip).
    +!goto(X,Y) <- ?pos(A,B); if (not obstacle & X<A) {+left; -right} elif (not obstacle & X>A) {+right; -left}; 
                                     if (not obstacle & Y>B) {+down; -up} elif (not obstacle & Y<B) {+up; -down}; 
                                     if (not obstacle & X==A) {-left; -right}; 
                                     if (not obstacle & Y==B) {-up; -down};
                                     !resolveObstacles.


    +!resolveObstacles: up <-  ?pos(A,B); !checkWaterUp; if (lastdown | notup | stone(A,B-1) | boolean | nogo(A,B-1) | (B==0)) {
                                                +obstacle;
                                                if (goal(C,D)&C<A){
                                                    !checkWaterLeft; if (lastright | notleft | stone(A-1,B) | boolean | nogo(A-1,B) | (A==0)) {
                                                        !checkWaterRight; if (lastleft | notright | stone(A+1,B) | boolean | nogo(A+1,B) | (A==54)) {
                                                            +nogo(A,B); !clearlast; /*+notup;*/ +lastdown; do(down);
                                                        } 
                                                        else {!clearlast; +lastright; do(right);}
                                                    } 
                                                    else{!clearlast; +lastleft; do(left);}
                                                }
                                                else{
                                                    !checkWaterRight; if (lastleft | notright | stone(A+1,B) | boolean | nogo(A+1,B) | (A==54)) {
                                                        !checkWaterLeft; if (lastright | notleft | stone(A-1,B) | boolean | nogo(A-1,B) | (A==0)) {
                                                            +nogo(A,B); !clearlast; /*+notup;*/ +lastdown; do(down);
                                                        } 
                                                        else {!clearlast; +lastleft; do(left);}
                                                    } 
                                                    else {!clearlast; +lastright; do(right);}
                                                }
                                          } 
                                          else {!clearforbidden; !clearlast; +lastup; -obstacle; do(up);}.

    +!resolveObstacles: right <- ?pos(A,B); !checkWaterRight; if (water(A,B)&water(A+1,B)&water(A+2,B)&((water(A+1,B+1)&B==0)|(water(A+1,B-1)&B==54))){
                                                +riverCrossing; if (B==0) {-up; +down;} else {-down; +up;}; !clearlast; !clearforbidden; !crossRiver;
                                            }
                                            elif (lastleft | notright | stone(A+1,B) | boolean | nogo(A+1,B) | (A==54)) {
                                                +obstacle;
                                                if (goal(C,D)&D<A){
                                                    !checkWaterUp; if (lastdown | notup | stone(A,B-1) | boolean | nogo(A,B+1) | (B==0)) {
                                                        !checkWaterDown; if (lastup | notdown | stone(A,B+1) | boolean | nogo(A,B-1)| (B==54)) {
                                                            +nogo(A,B); !clearlast; /*+notright;*/ +lastleft; do(left);
                                                        } 
                                                        else {!clearlast; +lastdown; do(down);}
                                                    } 
                                                    else{!clearlast; +lastup; do(up);}
                                                }
                                                else{
                                                    !checkWaterDown; if (lastup | notdown | stone(A,B+1) | boolean | nogo(A,B-1)| (B==54)) {
                                                        !checkWaterUp; if (lastdown | notup | stone(A,B-1) | boolean | nogo(A,B+1) | (B==0)) {
                                                            +nogo(A,B); !clearlast;  /*+notright;*/ +lastleft; do(left);
                                                        } 
                                                        else {!clearlast; +lastup; do(up);}
                                                    } 
                                                    else {!clearlast; +lastdown; do(down);}
                                                }
                                            }
                                            else {!clearforbidden; !clearlast; +lastright; -obstacle; do(right);}.

    +!resolveObstacles: down <- ?pos(A,B); !checkWaterDown; if (lastup | notdown | stone(A,B+1) | boolean | nogo(A,B+1)| (B==54)) {
                                                +obstacle;
                                                if (goal(C,D)&C<A){
                                                    !checkWaterLeft; if (lastright | notleft | stone(A-1,B) | boolean | nogo(A-1,B) | (A==0)) {
                                                        !checkWaterRight; if (lastleft | notright | stone(A+1,B) | boolean | nogo(A+1,B) | (A==54)) {
                                                            +nogo(A,B); !clearlast; /*+notdown;*/ +lastup; do(up);
                                                        } 
                                                        else {!clearlast; +lastright; do(right);}
                                                    } 
                                                    else{!clearlast; +lastleft; do(left);}
                                                }
                                                else{
                                                    !checkWaterRight; if (lastleft | notright | stone(A+1,B) | boolean | nogo(A+1,B) | (A==54)) {
                                                        !checkWaterLeft; if (lastright | notleft | stone(A-1,B) | boolean | nogo(A-1,B) | (A==0)) {
                                                            +nogo(A,B); !clearlast; /*+notdown;*/ +lastup; do(up);
                                                        } 
                                                        else {!clearlast; +lastleft; do(left);}
                                                    } 
                                                    else {!clearlast; +lastright; do(right);}
                                                }
                                           } 
                                           else {!clearforbidden; !clearlast; +lastdown; -obstacle; do(down);}.

    +!resolveObstacles: left <- ?pos(A,B); !checkWaterLeft; if (water(A,B)&water(A-1,B)&water(A-2,B)&((water(A-1,B+1)&B==0)|(water(A-1,B-1)&B==54))){
                                                +riverCrossing; if (B==0) {-up; +down;} else {-down; +up;}; !clearlast; !clearforbidden; !crossRiver;
                                            }
                                            elif (lastright | notleft | stone(A-1,B) | boolean | nogo(A-1,B) | (A==0)) {
                                                +obstacle;
                                                if (goal(C,D)&D<A){
                                                    !checkWaterUp; if (lastup | notup | stone(A,B-1) | boolean | nogo(A,B-1) | (B==0)) {
                                                        !checkWaterDown; if (lastdown | notdown | stone(A,B+1) | boolean | nogo(A,B+1)| (B==54)) {
                                                            +nogo(A,B); !clearlast; /*+notleft;*/ +lastright; do(right);
                                                        } 
                                                        else {!clearlast; +lastdown; do(down);}
                                                    } 
                                                    else{!clearlast; +lastup;do(up);}
                                                }
                                                else{
                                                    !checkWaterDown; if (lastup | notdown | stone(A,B+1) | boolean | nogo(A,B+1)| (B==54)) {
                                                        !checkWaterUp; if (lastdown | notup | stone(A,B-1) | boolean | nogo(A,B-1) | (B==0)) {
                                                            +nogo(A,B); !clearlast; /*+notleft;*/ +lastright; do(right);
                                                        } 
                                                        else {!clearlast; +lastup; do(up);}
                                                    } 
                                                    else {!clearlast; +lastdown; do(down);}
                                                }
                                           } 
                                           else {!clearforbidden; !clearlast; +lastleft; -obstacle; do(left)}.


    +!crossRiver: left <-   ?pos(A,B); !checkWaterLeft; if (pos(16, B)) {-riverCrossing;!goto;}
                            elif (boolean){
                                if (up) {
                                    !checkWaterUp; if (boolean){
                                        do(right);
                                    }
                                    else {do(up);}
                                }
                                else{
                                    !checkWaterDown; if (boolean){
                                        do(right);
                                    }
                                    else {do(down);}
                                }
                            }
                            else {do(left);}.
    +!crossRiver: right <-  ?pos(A,B); !checkWaterRight; if (pos(33, B)) {-riverCrossing;!goto;}
                            elif (boolean){
                                if (up) {
                                    !checkWaterUp; if (boolean){
                                        do(left);
                                    }
                                    else {do(up);}
                                }
                                else{
                                    !checkWaterDown; if (boolean){
                                        do(left);
                                    }
                                    else {do(down);}
                                }
                            }
                            else {do(right);}.


+step(X):bag_full & depot(A,B)& pos(A,B)<-drop(all); -left; +right; -up; +down; ?position(C,D).

//+step(X):bag_full & depot(A,B) & pos(A,B) <- -left; +right; -up; +down; drop(all).
+step(X):bag_full & depot(A,B) & pos(C,D) <- +returnPos(C,D); !goto(A,B); do(skip).
//vodu zatial neberie, lebo by sa pri tom zacyklil

/*+step(X): water(A,B) & pos(A,B)& not(water(A-1,B)) <- do(left).
+step(X): water(A,B) & pos(A,B)& not(water(A+1,B)) <- do(right). 
+step(X): water(A,B) & pos(A,B)& not(water(A,B-1)) <- do(up).
+step(X): water(A,B) & pos(A,B)& not(water(A,B+1)) <- do(down).*/

+step(X): goBack <- ?position(A,B); !goto(A,B); do(skip).
+step(X): wood(A,B)&pos(A,B) <- .abolish(position(_,_)); +position(A,B); do(pick);do(skip) .
+step(X): gold(A,B)&pos(A,B)<-.abolish(position(_,_)); +position(A,B);do(pick); do(skip).
+step(X): pergamen(A,B)&pos(A,B)<-.abolish(position(_,_)); +position(A,B);do(pick); do(skip).
+step(X): gloves(A,B) & pos(A,B) <- do(pick);do(skip).
+step(X): stone(A,B)&pos(A+1,B)<- .abolish(position(_,_)); +position(A+1,B); do(dig,w); do(skip).
+step(X): stone(A,B) & pos(A-1, B) <- .abolish(position(_,_)); +position(A-1,B); do(dig,e); do(skip).
+step(X): stone(A,B) & pos(A, B+1) <- .abolish(position(_,_)); +position(A,B+1);do(dig,n); do(skip).
+step(X): stone(A,B) & pos(A, B-1) <- .abolish(position(_,_)); +position(A,B-1);do(dig,s); do(skip).
+step(X): not(bag_full) &  position(A,B) & pos(A,B) &not(position(-1,-1)) <- .abolish(position(_,_)); .abolish(returnPos(_,_)); +position(-1,-1);!gov2; do(skip).
+step(X): not(bag_full) &  position(A,B) & not(position(-1,-1)) <- ?position(A,B);+goBack; !goto(A,B); do(skip).
+step(X) <- !gov2; do(skip).

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
												elif(water(A,B) & not water(A, B-1) &  not stone(A+1, B)& B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A, B+1)& not stone(A+1, B)&B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A+1, B+1) & not stone(A+1, B)&B > 0 & B < C -1){
													+canGoR(t);
												}
												elif(water(A,B) & not water(A+1, B-1) &not stone(A+1, B)& B > 0 & B < C -1){
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
												elif(water(A,B) & not water(A, B-1) & not stone(A-1,B)& B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A, B+1)& not stone(A-1,B)&B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A-1, B+1) & not stone(A-1,B)&B > 0 & B < C -1){
													+canGoL(t);
												}
												elif(water(A,B) & not water(A-1, B-1) & not stone(A-1,B)&B > 0 & B < C -1){
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
												elif(water(A,B) & not water(A-1, B) &  not stone(A, B+1) &A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A+1, B)&not stone(A, B+1) & A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A+1, B+1) &not stone(A, B+1) & A > 0 & A < C -1){
													+canGoD(t);
												}
												elif(water(A,B) & not water(A-1, B+1) & not stone(A, B+1) &A > 0 & A < C -1){
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
												elif(water(A,B) & not water(A-1, B) & not stone(A,B-1) &A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A+1, B)&not stone(A,B-1) & A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A+1, B-1) &  not stone(A,B-1) &A > 0 & A < C -1){
													+canGoU(t);
												}
												elif(water(A,B) & not water(A-1, B-1) & not stone(A,B-1) &A > 0 & A < C -1){
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
+!gov2 <- -left; +right; -up; +down; do(skip).

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
