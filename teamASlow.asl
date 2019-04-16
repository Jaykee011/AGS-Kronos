//Project: AGS project - multiagent system
//Author: Jakub Zapletal (xzaple36)
//File: Agent with farsight

trusted(teamAFast).
trusted(teamAMiddle).
trusted(teamASlow).
trusted(teamADruid).

glovesneeded.
spectaclesneeded.
bootsneeded.

//Faze bystrozora:
////preparation - snaha dostat se do leveho horniho rohu pro zacatek scoutingu
////adjustment - zmena Y pozice agenta pri hadim pohybu
////scouting - mapovani hry <- zacina v tomto stavu
//////spiralovite prohledavani prostoru hry -> dostane se do leveho horniho rohu a pak postupuje po radcich tak aby mel nejlepsi pokryti
////spectaclesFound - honba za brylemi
//////Nastane jakmile zahledne bryle ... ulozi si puvodni pozici -> pozene se za brylemi -> vrati se a pokracuje ve scoutingu, tentokrate braje v potaz vyssi dohled
////riverCrossing - hledani brodu na rece
//////Modifikace scoutingu, kdy narazil na reku -> scouting pokracuje, ale podel reky, kde primarne hleda brod -> po nalezeni pozici brodu rozesle ostatnim a pokracuje ve scoutingu
////gathering - sber surovin
//////Jakmile doscoutoval nebo nastava nouzova situace
preparation.

//this counter is used as to not skip a portion of the map when trying to get around water while scouting
waterCounter(0).

+step(0) <- .println("Strike the earth!");?grid_size(A,B);+right(A);+down(B);+left;!getToPosition.

//controller
    +step(X): preparation <- !getToPosition.
    +step(X): scouting <- !scout.
    +step(X): gathering <- .println("finished"); do(skip). 

//water pathing
    +!scout: water(A,B)&pos(A,B)&waterCounter(7)&left <- -waterCounter(7); +waterCounter(0); -left; +right; do(right).
    +!scout: water(A,B)&pos(A,B)&waterCounter(7)&right <- -waterCounter(7); +waterCounter(0); +left; -right; do(left).
    +!scout: water(A,B)&pos(A,B)&left <- +down; -scouting; +adjusting; do(right); ?waterCounter(W); +waterCounter(W+1); -waterCounter(W); !adjust(1).
    +!scout: water(A,B)&pos(A,B)&right <- +down; -scouting; +adjusting; do(left); ?waterCounter(W); +waterCounter(W+1); -waterCounter(W); !adjust(1).

//finished route
    +!scout: pos(3,51)&left <- -scouting; +gathering; do(skip).
    +!scout: pos(51,51)&right <- -scouting; +gathering; do(skip).

//snake scout
    //adjusting height - A STEP NEEDS TO HAPPEN BEFORE THE adjust PLAN BECAUSE OF THE wait!!
    +!adjust(X): pos(A,B)&water(A,B+1)&left <- .wait({+step(Y)}); do(left); !adjust(X).
    +!adjust(X): pos(A,B)&water(A,B+1)&right <- .wait({+step(Y)}); do(right); !adjust(X).
    +!adjust(0) <- .wait({+step(Y)}); -adjusting; -up; -down; +scouting; !scout.    
    +!adjust(X): pos(A, 51) <- .wait({+step(Y)}); -adjusting; -up; -down; +scouting; !scout.
    +!adjust(X): up <- .wait({+step(Y)}); do(up); !adjust(X-1).
    +!adjust(X): down <- .wait({+step(Y)}); do(down); !adjust(X-1).
    //scout route
    +!scout: (pos(3,B)|(pos(A,B)&(stone(C,B)&C<=A+3)))&left <- -left; +right; +down; -scouting; +adjusting; ?waterCounter(W); -waterCounter(W); +waterCounter(0); do(down); !adjust(6).
    +!scout: (pos(51,B)|(pos(A,B)&(stone(C,B)&C>=A-3)))&right <- -right; +left; +down; -scouting; +adjusting; ?waterCounter(W); -waterCounter(W); +waterCounter(0); do(down); !adjust(6).
    +!scout: left <- do(left).
    +!scout: right <- do(right).
    //get to the top left of map to start scout route - TODO: Adjust to work for scenarios 2 && 3
    //+!getToPosition: pos(A,B)&A<
    +!getToPosition: pos(3,3) <- -left;-up;+right;-preparation;+scouting;do(right).
    +!getToPosition: pos(A,3)&up <- -up; +right; do(right).
    +!getToPosition: pos(3,B)&left <- -left; +up; do(up).
    +!getToPosition: up <- do(up).
    +!getToPosition: left <- do(left).
    +!getToPosition: right <- do(right).
    +!getToPosition: down <- do(down).

//circle scout
    //+!scout: pos(3,B)&left <- -left; +up; do(up).
    //+!scout: pos(A,3)&up <- -up; +right; do(right).
    //+!scout: pos(51,B)&right <- -right; +down; do(down).
    //+!scout: pos(A,51)&down <- -down; +left; do(left).
    //+!scout: left <- do(left).
    //+!scout: right <- do(right).
    //+!scout: up <- do(up).
    //+!scout: down <- do(down).


//+step(X): wood(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): gold(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): pergamen(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): stone(A,B) & pos(A,B) & not(bag_full) <-do(pick).
//+step(X): water(A,B) & pos(A,B) & not(bag_full) <- do(pick).


//+step(X)<-!go.
 
 // do(right);do(right);do(right);do(left);do(left);do(left).
 
 //+!go<-do(skip);do(skip);do(skip).

// +!go: right & pos(A,B) & right(C)&A<C-1<- do(right).
// +!go: right <- -right;+left;do(up).
 
// +!go: left & pos(A,B) & A>0 <- do(left).	
// +!go: left<-  -left;+right;do(up).
