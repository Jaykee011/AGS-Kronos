  
+step(0) <- .println("START");?grid_size(A,B);+right(A);+down(B);+right;do(skip).

//+step(X): wood(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): gold(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): pergamen(A,B) & pos(A,B) & not(bag_full)<-do(pick).
//+step(X): stone(A,B) & pos(A,B) & not(bag_full) <-do(pick).
+step(X): water(A,B) & pos(A,B) & not(bag_full) <- do(pick).


+step(X)<-!go.
 
 // do(right);do(right);do(right);do(left);do(left);do(left).
 
 //+!go<-do(skip);do(skip);do(skip).

 +!go: right & pos(A,B) & right(C)&A<C-1<- do(right).
 +!go: right <- -right;+left;do(up).
 
 +!go: left & pos(A,B) & A>0 <- do(left).	
 +!go: left<-  -left;+right;do(up).
