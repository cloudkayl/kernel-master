INTERFACE WrClass;
IMPORT Wr;
FROM Thread IMPORT Alerted;
FROM Wr IMPORT Failure;

TYPE 
  Private <: ROOT;

REVEAL
  Wr.T = Private BRANDED OBJECT
           buff       : REF ARRAY OF CHAR;
           st         : CARDINAL;           (* index into buff *)
           lo, hi, cur: CARDINAL            := 0; (* indexes into c(wr) *)
           closed := TRUE;       (* Subtype's init method should set this
                                    to FALSE *)
           seekable, buffered: BOOLEAN
         METHODS
           seek      (n: CARDINAL) RAISES {Failure, Alerted};
           putString (READONLY a: ARRAY OF CHAR) RAISES {Failure, Alerted}
                                                         := PutStringDefault;
           length (): CARDINAL RAISES {Failure, Alerted} := LengthDefault;
           flush  () RAISES {Failure, Alerted}           := FlushDefault;
           close  () RAISES {Failure, Alerted}           := CloseDefault
         END;


(* Let wr be a writer, which abstractly is given by c(wr), target(wr),
cur(wr), closed(wr), seekable(wr), buffered(wr).  The actual
representation of wr is an object of type Wr.T.  The wr.cur,
wr.closed, wr.seekable, and wr.buffered fields in the object represent
the corresponding abstract attributes of wr.  The wr.buff, wr.st,
wr.lo, and wr.hi fields in the object represent a buffer containing
the unflushed part of c(wr).  The target of the writer is represented
in some class-specific way, which is not specified by this interface.

More precisely, we say that the state of the writer object wr 
is valid if the following conditions V1 through V5 hold:

V1. the cur field and the booleans are correct:
     	wr.cur = cur(wr)  AND wr.closed = closed(wr)  AND 
	wr.buffered = buffered(wr)  AND wr.seekable = seekable(wr)

V2. the indexes of any unflushed characters are in the range
[lo..cur-1]. That is, for all i not in [wr.lo..wr.cur-1],

	c(wr)[i] = target(wr)[i]

V3. the (possibly) unflushed characters are stored in buff starting
with buff[st].  That is, for all i in [wr.lo..wr.cur-1],

    	c(wr)[i] = wr.buff[wr.st + i - wr.lo]

(Usually st is zero. Non-zero values may be useful to satisfy buffer
alignment constraints.)

V4. the current position is either contained in the buffer, or just
past the buffer:

	wr.lo <= wr.cur <= wr.hi

It is possible that buff = NIL in a valid state, since the range of
i's in V3 can be empty; for example, in the case lo = hi = cur.

V5. if closed(wr) then wr.buff = NIL AND wr.lo = wr.hi

We say that the state is ready if the buffer contains the current
position; that is, if

   NOT wr.closed AND wr.buff # NIL AND  wr.lo <= cur(wr) < wr.hi

If the state is ready, then Wr.PutChar can be implemented by storing
into the buffer.  The class-independent code does exactly this, until
the buffer is full, at which point it calls a class method to consume
the buffer and provide a new one.  Together V4 and V5 imply
that if wr.cur # wr.hi then wr.buff # NIL and NOT wr.closed.  Therefore
a valid writer is ready if "wr.cur # wr.hi".

In general, the class-independent code modifies cur and buff[i] for i
in the range [st..st+(hi-1)-lo], but not the buff reference itself,
st, lo, or hi (except that "Wr.Close" modifies "wr.lo" and "wr.cur" and
sets "wr.buff" to NIL in order to maintain invariant V5).  The
class-independent code locks the writer before calling any methods;
therefore, no two method activations initialized by the class-independent
code will be concurrent. A method must not apply operations from the Wr
interface to the writer itself, or deadlock will result.
   
Here are the specifications for the methods:

The method call wr.seek(n) treats n as a position to
seek to, and moves the buffer to contain this position. More
precisely:

  - Given a valid state, wr.seek(n) must produce a valid ready
    state in which wr.cur = MIN(n, len(wr)) and c(wr) is
    unchanged.

An important special case is when n = wr.cur = wr.hi; that 
is, when the buffer has overflowed and the effect of the seek is 
simply to advance from the last character of a buffer to the first 
character of a new buffer.  Every writer class (seekable or not) 
must provide a seek method that supports this special case.  The 
method must support the general case only if the writer is seekable.

The putString method is used to implement Wr.PutString and is
called with the writer lock held.  Efficient implementations override
this method to avoid unnecessary copying by transferring directly into
the writer target, bypassing the writer buffer.  The default
implementation is correct for any class, but always copies through
the writer buffer.

The flush method updates the underlying target of the writer.  That
is: Given a valid state, wr.flush() must produce a valid state in
which c(wr) and cur(wr) are unchanged and target(wr) = c(wr).  If a
writer is unbuffered, the class-independent code will call the flush
method after every modification to the buffer.

The close method releases all resources associated with a writer.
That is: Given a valid state in which target(wr) = c(wr), the call
wr.close() must release all resources associated with wr. The exact
meaning is class-specific V. "Wr.Close" sets the "buff" field
to "NIL", so the method need not do this.  Validity is not 
required when the method returns, since after it returns, the
class-independent code will set the closed bit in the writer, 
which makes the rest of the state irrelevant, even if it is invalid.

The length method returns the length of the writer.  That is: Given a
valid state, wr.length() must return len(wr), leaving a valid state in
which c(wr) and cur(wr) are unchanged.

Finally, here are two procedures that are essential for implementing 
class-specific operations.  *)


PROCEDURE Lock(wr: Wr.T) RAISES {};
(* The writer wr must be unlocked; lock it and make its state valid. *)

PROCEDURE Unlock(wr: Wr.T);
(* The writer wr must be locked and valid; unlock it and restore 
the private invariant of the writer implementation. *)

(* A class-specific operation on a writer wr should use the following
template:

      Lock(wr); TRY ... FINALLY Unlock(wr) END

The methods don't have to do this, since the class-independent 
code automatically locks and unlocks the writer around method calls. 
The next section provides examples of the use of Lock and 
Unlock.

The last declarations in the interface are for the default methods: *)

PROCEDURE PutStringDefault(wr: Wr.T; READONLY a: ARRAY OF CHAR)
    RAISES {Failure, Alerted};

PROCEDURE LengthDefault(wr: Wr.T): CARDINAL RAISES {};

PROCEDURE CloseDefault(wr: Wr.T) RAISES {};

PROCEDURE FlushDefault(wr: Wr.T) RAISES {};

(* LengthDefault returns wr.cur, while CloseDefault and FlushDefault
   are no-ops. *)

END WrClass.
