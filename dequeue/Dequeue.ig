GENERIC INTERFACE Dequeue(Elem);
CONST Brand = "(Dequeue "& Elem.Brand & ")";

TYPE
  T = Elem.T;

  Iterator = RECORD
    head: T;
    cur: T;
  END;

PROCEDURE NewHeader() : T;
(* A T is represented by a header. All the members can be
  reached from the header. NewHeader creates a null T.
 *)

PROCEDURE InsertHead(head : T; t : T);
(* Insert "t" at the head of the dequeue "head". "head.next" becomes the
   newly inserted item.
 *)

PROCEDURE InsertTail(head: T; t: T);
(* Insert "t" at the tail of the dequeue "head". "head.prev" becomes the
   newly inserted item. *)

PROCEDURE Member(head: T; t: T): BOOLEAN;
(* Return TRUE if the dequeue chain starting from "head" contains "t". *)
  
PROCEDURE Empty(head: T): BOOLEAN;
(* See if the dequeue is empty or not. Dequeue is empty when
   "head.next = head = head.prev". *)

PROCEDURE Remove(t: T);
(* Remove the element "t" from whatever dequeue it's linked to. *)

PROCEDURE RemoveHead(head: T): T;
(* Remove the element that is at the head of the dequeue, and store
   If "head" is empty, then this proc will crash. *)
  
PROCEDURE RemoveHeadSafe(head: T): T;
(* Remove the element at the head of the queue "head". If the queue is
   empty, then the proc returns NIL. *)
  
PROCEDURE RemoveTail(head: T): T;
(* Remove the entry that is at the tail of the "head".
   If "head" is empty, then this proc will crash. *)
  
PROCEDURE Size(head: T): INTEGER;
(* Return the number of elements in the dequeue. *)

  
(*
 Iterator stuff
 *)
PROCEDURE Iterate(head: T): Iterator;
(* Returns a iterator that traverses all the items in the dequeue
   in head-to-tail order. The iterator is not an object like in other
   libraries to gain performance. *)
  
PROCEDURE NextItr(VAR itr: Iterator; VAR t: T): BOOLEAN;


   
  


PROCEDURE Allocate() : T;
PROCEDURE Free(t: T);
  
END Dequeue.
