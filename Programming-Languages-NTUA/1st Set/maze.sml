
fun parse file =
    let 
        fun readInt input =
            Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    
        val inStream = TextIO.openIn file 

        val n_lines = readInt inStream 
        val m_collums = readInt inStream
        val _ = TextIO.inputLine inStream

        fun readInts acc =
        case TextIO.inputLine inStream of
            NONE => rev acc
            | SOME line => readInts (explode (String.substring (line,0,m_collums))::acc)
    
        val arrows =readInts []:char list list 
        val _ = TextIO.closeIn inStream

    in 
        (n_lines,m_collums, arrows)
    end


(**)


local 
    fun myprint5 arrowarray [] =(print ("emptylist")) 
    | myprint5 arrowarray (x::t:(int*int) list) =     (print ("hello");Array2.update(arrowarray, #1 x, #2 x, #"O"))

in
    fun checkingthehink arrowarray line collum list =
    let
            
        val v1 =  Array2.sub(arrowarray,line,collum)
        val printable_thing = Char.toString v1 
        val aray_total_lines= Array2.nRows (arrowarray)-1
        val aray_total_collums= Array2.nCols(arrowarray)-1



        val why_god = if printable_thing="D"  andalso line=aray_total_lines     then   Array2.update (arrowarray, line,collum, #"O") else(
                        if printable_thing="U"  andalso line=0                    then     Array2.update (arrowarray, line,collum, #"O")else(
                        if printable_thing="R"  andalso collum=aray_total_collums then  Array2.update (arrowarray, line,collum, #"O") else(
                        if printable_thing="L"  andalso collum=0                  then  Array2.update (arrowarray, line,collum, #"O") else())))
            
        val p_line = if printable_thing="D"    then line+1 else(
                        if printable_thing="U"         then line-1 else(
                        if printable_thing="R"   then line else(
                        if printable_thing="L"    then line else(1))))
        val p_collum =if printable_thing="D"    then collum else(
                        if printable_thing="U"         then collum else(
                        if printable_thing="R"   then collum+1 else(
                        if printable_thing="L"    then collum-1 else(1))))
            
            
        val why_god2= 
                if Array2.sub(arrowarray,line,collum)= #"O" then (#"O") (*everithing in set gets an O , set gets empty//(print ("helo\n"); myprint5 arrowarray list)*) 
                else (
                    if Array2.sub(arrowarray,line,collum)= #"X" then((*print ("iam x\n");*) #"X") else
                    ( 
                        if Array2.sub(arrowarray,p_line,p_collum)= #"O" then ( Array2.update (arrowarray, line,collum, #"O"); #"O" )
                        else 
                        (
                            if Array2.sub(arrowarray,p_line,p_collum)= #"X" 
                            then ( Array2.update (arrowarray, line,collum, #"X");(*print ("iam x\n");*) #"X")
                            else 
                            (     
                                Array2.update (arrowarray, line,collum, #"X");
                                Array2.update (arrowarray, line,collum, checkingthehink arrowarray p_line p_collum list ); 
                                (*add to set// (line,collum)::list;*) Array2.sub(arrowarray, line,collum)
                            )
                        )
                    )

                )

            
    in 
        why_god2
    end
end


fun   up_recersion 0 collum arrows =    (checkingthehink arrows 0    collum [])
    | up_recersion line 0 arrows =      (checkingthehink arrows line 0 [];        up_recersion (line-1) 0      arrows)
    | up_recersion line collum arrows = (checkingthehink arrows line collum [];   up_recersion (line-1) collum arrows)

fun left_up_recersion   0    0      arrows =  (checkingthehink arrows 0    0 [])
    | left_up_recersion 0 collum    arrows = (checkingthehink arrows 0    collum [];  left_up_recersion  0 (collum-1) arrows)
    | left_up_recersion line 0      arrows = (checkingthehink arrows line 0    [] ;       up_recersion  (line-1) (0) arrows)
    | left_up_recersion line collum arrows = (checkingthehink arrows line collum [];       up_recersion  (line-1) (collum) arrows; 
                                                                                   left_up_recersion  (line) (collum-1) arrows )


fun chech n m arr accc=
    let
        val why_god2=  if Array2.sub(arr,n,m)= #"O" then (accc) else (accc+1)
    in 
    why_god2
    end


fun countinupleft n_max 0 0 arr accc = (chech 0 0 arr accc)
    | countinupleft n_max 0 m arr accc= countinupleft n_max n_max (m-1) arr (chech 0 m arr accc)
    | countinupleft n_max n m arr accc= countinupleft n_max (n-1) m arr (chech n m  arr accc)

fun solve (n_lines,m_collums, arrows) =
    let 
    val arrowarray =Array2.fromList arrows
    in
    
    
    left_up_recersion (n_lines-1) (m_collums-1) (arrowarray);
    print (Int.toString (countinupleft (n_lines-1) (n_lines-1) (m_collums-1) (arrowarray) 0));
    print ("\n")

    end















fun loop_rooms fileName = solve (parse fileName)