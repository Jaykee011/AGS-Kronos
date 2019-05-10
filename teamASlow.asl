//Project: AGS project - multiagent system
//Author: Jakub Zapletal (xzaple36)
//File: Agent with farsight

//Faze bystrozora:
////gotoing - snaha dostat se na urcity koordinat
////adjustment - zmena Y pozice agenta pri hadim pohybu
////scouting - mapovani hry <- zacina v tomto stavu
//////spiralovite prohledavani prostoru hry -> dostane se do leveho horniho rohu a pak postupuje po radcich tak aby mel nejlepsi pokryti
////spectaclesFound - honba za brylemi
//////Nastane jakmile zahledne bryle ... ulozi si puvodni pozici -> pozene se za brylemi -> vrati se a pokracuje ve scoutingu, tentokrate braje v potaz vyssi dohled
////riverCrossing - hledani brodu na rece
//////Modifikace scoutingu, kdy narazil na reku -> scouting pokracuje, ale podel reky, kde primarne hleda brod -> po nalezeni pozici brodu rozesle ostatnim a pokracuje ve scoutingu
////gathering - sber surovin
//////Jakmile doscoutoval nebo nastava nouzova situace

bootsneeded.
glovesneeded.
spectaclesneeded.
//this counter is used as to not skip a portion of the map when trying to get around water while scouting
waterCounter(0).

//used as a "return" value
boolean.

//helper plans
    +!clearlast <- -lastleft; -lastright; -lastup; -lastdown.
    +!clearforbidden <- -notup; -notdown; -notleft; -notright.
    +!checkWaterUp <- ?pos(A,B); if (water(A,B)&water(A+1,B-1)&water(A,B-1)&water(A,B-2)&water(A-1,B-1)) {+boolean} else {-boolean}.
    +!checkWaterDown <- ?pos(A,B); if (water(A,B)&water(A+1,B+1)&water(A-1,B+1)&water(A,B+2)&water(A,B+1)) {+boolean} else {-boolean}.
    +!checkWaterLeft <- ?pos(A,B); if (water(A,B)&water(A-1,B)&water(A-2,B)&((water(A-1,B+1)|B==0)&(water(A-1,B-1)|B==54))) {+boolean} else {-boolean}.
    +!checkWaterRight <- ?pos(A,B); if (water(A,B)&water(A+1,B)&water(A+2,B)&((water(A+1,B+1)|B==0)&(water(A+1,B-1)|B==54))) {+boolean} else {-boolean}.



//controller
    +step(0) <- ?depot(X,Y); +toGather; +gotoing; +left; +down; +findWater; +waterLeft; +goal(X,Y); !goto.
    +step(X): riverCrossing <- !crossRiver.
    +step(X): gotoing <- !goto.
    +step(X): scouting <- !scout.
    +step(X): dowseSomeRod <- !dowsingRod.
    +step(X): gathering <- !gather.

    +!gather: atWater <- -atWater; do(pick); -gotoWater; +gotoDepo; ?depot(X,Y); +goal(X,Y); -left; +right; -atWater.//!goto.
    +!gather: atDepo <- -atDepo; drop(all); -gotoDepo; +gotoWater; ?wattaah(U,V); +goal(U,V); -right; +left; -atDepo.//!goto.
    +!gather <- !goto.

//find water
    //+!dowsingRod: water(A,B)&waterLeft <- !nearestWater; ?goal(C,D); -goal(C,D); ?wattaah(X,Y); +goal(X,Y); -findWater; -dowseSomeRod; +gotoWater; +gathering; !gather.
    +!dowsingRod: pos(A,B)&water(C,D) <- !nearestWater; ?goal(X,Y); -goal(X,Y); ?wattaah(F,G); +goal(F,G); -findWater; -dowseSomeRod; +gathering; +gotoWater; !goto.
    +!dowsingRod: pos(3, B) <- !clearforbidden; !clearlast; ?goal(X,Y); -goal(X,Y); -findWater; -waterLeft; -left; +right; ?pos(A,B); +goal(52, B); !goto.
    +!dowsingRod <- !goto.

    +!nearestWater <- for (water(A,B)) {
                        .print(A,"|",B)
                        if (wattaah(X,Y)){
                            ?wattaah(X,Y)
                            ?pos(C,D);
                            if (X > C) {+tempX(X-C);} else {+tempX(C-X);};
                            if (Y > D) {+tempY(Y-D);} else {+tempY(D-Y);};
                            ?tempX(E); ?tempY(F); +temp1(E+F); -tempX(E); -tempY(F);
                            if (A > C) {+tempX(A-C);} else {+tempX(C-A);};
                            if (B > D) {+tempY(B-D);} else {+tempY(D-B);};
                            ?tempX(L); ?tempY(K); +temp2(L+K); -tempX(L); -tempY(K);
                            ?temp1(T); ?temp2(G); -temp1(T); -temp2(G);
                            if (T > G) {.print(X,Y,"X",A,B,"|",T,"X",G);-wattaah(X,Y); +wattaah(A,B);}
                        }
                        else{
                            +wattaah(A,B);
                        };
                    }.

//snake scout
    //water pathing
    +!scout: water(A,B)&pos(A,B)&waterCounter(7)&left <- -waterCounter(7); +waterCounter(0); -left; +right; do(right).
    +!scout: water(A,B)&pos(A,B)&waterCounter(7)&right <- -waterCounter(7); +waterCounter(0); +left; -right; do(left).
    +!scout: water(A,B)&pos(A,B)&left <- +down; -scouting; +adjusting; do(right); ?waterCounter(W); +waterCounter(W+1); -waterCounter(W); !adjust(1).
    +!scout: water(A,B)&pos(A,B)&right <- +down; -scouting; +adjusting; do(left); ?waterCounter(W); +waterCounter(W+1); -waterCounter(W); !adjust(1).

    //finished route    
    +!scout: pos(3,51)&left <- -scouting; +gathering; do(skip).
    +!scout: pos(51,51)&right <- -scouting; +gathering; do(skip).
    
    //scout route
    +!scout: (pos(3,B)|(pos(A,B)&(stone(C,B)&C>=A-3&C<A)))&left <- -left; +right; +down; -scouting; +adjusting; ?waterCounter(W); -waterCounter(W); +waterCounter(0); do(down); !adjust(6).
    +!scout: (pos(51,B)|(pos(A,B)&(stone(C,B)&C<=A+3&C>A)))&right <- -right; +left; +down; -scouting; +adjusting; ?waterCounter(W); -waterCounter(W); +waterCounter(0); do(down); !adjust(6).
    +!scout: left <- do(left).
    +!scout: right <- do(right).

    //adjusting height - A STEP NEEDS TO HAPPEN BEFORE THE adjust PLAN BECAUSE OF THE wait!!
    +!adjust(X): pos(A,B)&water(A,B+1)&left <- .wait({+step(Y)}); do(left); !adjust(X).
    +!adjust(X): pos(A,B)&water(A,B+1)&right <- .wait({+step(Y)}); do(right); !adjust(X).
    +!adjust(0) <- .wait({+step(Y)}); -adjusting; -up; -down; +scouting; !scout.    
    +!adjust(X): pos(A, 51) <- .wait({+step(Y)}); -adjusting; -up; -down; +scouting; !scout.
    +!adjust(X): up <- .wait({+step(Y)}); do(up); !adjust(X-1).
    +!adjust(X): down <- .wait({+step(Y)}); do(down); !adjust(X-1).


//GOTO
    +!goto: goal(X,Y)&(stone(X,Y) | pos(X,Y)) <-    ?goal(A,B); -goal(A,B); +right; -left; -down; -up; !clearforbidden; !clearlast; 
                                                    if (gotoing) {-gotoing}; 
                                                    if (toScout) {+scouting; !scout}
                                                    elif (findWater) {?depot(C,D); +goal(1,D); -gotoDepo; -right; -up; -down; +left; +dowseSomeRod; !dowsingRod}
                                                    elif (gotoWater) {+atWater; !gather}
                                                    elif (gotoDepo) {+atDepo; !gather}.
    +!goto <- ?goal(X,Y); ?pos(A,B); if (not obstacle & X<A) {+left; -right} elif (not obstacle & X>A) {+right; -left}; 
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