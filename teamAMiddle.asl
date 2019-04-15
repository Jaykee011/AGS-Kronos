
glovesneeded.

+step(0) <- .println("START");?grid_size(A,B);+right(A);+down(B);+right;do(skip);do(skip).

+!goto(A,B):pos(C,D)&A<C<-do(left).
+!goto(A,B):pos(C,D)&A>C<-do(right).
+!goto(A,B):pos(C,D)&B<D<-do(up).
+!goto(A,B):pos(C,D)&D<B<-do(down).
+!goto(A,B)<-do(skip).



+step(X):bag_full & depot(A,B)& pos(A,B)<-.println("$$$$$$$$$$$$$$$ odlozil bych si");drop(all).

+step(X):bag_full & depot(A,B)<-!goto(A,B);!goto(A,B).

+step(X): water(A,B) & pos(A,B) <- do(pick).
+step(X): wood(A,B)&pos(A,B)<-do(pick).
+step(X): gold(A,B)&pos(A,B)<-do(pick).
+step(X): pergamen(A,B)&pos(A,B)<-do(pick).
+step(X): stone(A,B)&pos(A,B)<-do(skip);do(skip).

+step(X): gloves(A,B)&pos(A,B)&glovesneeded<--glovesneeded;do(pick).
 
+step(X)<-!go.


 +!go: right & pos(A,B) & right(C)&A<C-1<- do(right);do(skip).
 +!go: right <- -right;+left;do(down);do(skip).	
 +!go: left & pos(A,B) & A>0 <- do(left);do(skip).	
 +!go: left<-  -left;+right;do(down);do(skip).



