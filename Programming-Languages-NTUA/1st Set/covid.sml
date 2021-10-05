fun parse file =
    let
    (* A function to read an integer from specified input. *)
        fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    (* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read integers  and consume newline. *)
    val m = readInt inStream
    val n = readInt inStream
    val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
    fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
      | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n, m, readInts m [])
    end

fun min a b = if a<b then a else b;

fun max a b= if a>b then a else b;

fun Lmin arr n retarr i =
    if i=n then retarr
    else 
        let 
            val arri =Array.sub(arr,i)
            val retarrim =Array.sub(retarr,i-1)
        in
        if arri<retarrim then (Array.update(retarr,i,Array.sub(arr,i)); Lmin arr n retarr (i+1))
        else  (Array.update(retarr,i,Array.sub(retarr,i-1)); Lmin arr n retarr (i+1))
        end

(* fun Rmax  arr n retarr i =
    if i=n then retarr
    else 
      (Array.update(retarr,i,min(Array.sub(arr,i) Array.sub(retarr,i-1))); Rmax arr n retarr (i+1))

    min(Array.sub(arr,i) Array.sub(retarr,i-1) *)

(* 
Start from 1 less than n ex.3*)


fun Rmax arr n retarr =
    if n<0 then retarr
    else 
        let 
            val arri =Array.sub(arr,n)
            val retarrim =Array.sub(retarr,n+1)
        in
        if arri>retarrim then (Array.update(retarr,n,Array.sub(arr,n)); Rmax arr (n-1) retarr )
        else  (Array.update(retarr,n,Array.sub(retarr,n+1)); Rmax arr (n-1) retarr )
        end
        ;

(* o retarr prepei na einai typou [arr[0],0,0,0,0,... me n stoixeia] kai i=1*)
fun pref arr n retarr i  =
    if i=n then retarr
    else 
        let 
            val arri =Array.sub(arr,i)
            val retarri=Array.sub(retarr,i-1)
        in 
        
        (Array.update(retarr,i, (retarri+arri) ); pref arr n retarr (i+1))
        end ;
(*retarr me n stoixeia,i=0*)

fun modify arr x n retarr i = 
    if i=n then retarr
    else 
        let
            val arrix= (0-Array.sub(arr,i)-x)
        in 

        (Array.update(retarr, i, arrix ); modify arr x n retarr (i+1))
        end



(* i=j=0 kai  maxDiff=-1   *)

fun merge i j n maxDiff Lminl Rmaxl=
if i<n andalso j<n then (
    let 
    
        val Li=Array.sub(Lminl,i)
        val Ri=Array.sub(Rmaxl,j)
        val maxD= max maxDiff (j-i)
    in 
    if Li<Ri then merge  i (j+1) n maxD Lminl Rmaxl 
    else merge  (i+1) j n maxDiff Lminl Rmaxl 
    end )

else if maxDiff=n-1 then maxDiff+1
    else maxDiff    




(* Dummy solver & requested interface. *)
fun solve (n,m, sizelist) =
    let 
        val arrowarray =Array.fromList sizelist
        val arrowarray2 =Array.fromList sizelist
        val mymodified = modify arrowarray n m arrowarray2 0

        val temparray=Array.array(m,0)
        val temparray2=Array.array(m,0)
        val temparray3=Array.array(m,0)
        val temparray4=Array.array(m,0)

        val _ =Array.update(temparray,0,Array.sub(mymodified,0))
        
        val mypref = pref mymodified m temparray 1

        val tempint1=Array.sub(mypref,0)

        val tempint2=Array.sub(mypref,m-1)


        val _ =Array.update(temparray2,0,tempint1)
        val _ =Array.update(temparray3,m-1,tempint2)

        val mylmin = Lmin mypref m temparray2 1

        val myrmax = Rmax mypref (m-2) temparray3

        (*val mygad = merge 0 0 m ~1 mylmin myrmax*)

    in
        print (Int.toString (merge 0 0 m ~1 mylmin myrmax));
    print ("\n")
    end



fun longest fileName = solve (parse fileName)    