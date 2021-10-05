fun parse file =
    let
        fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    (* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read integers  and consume newline. *)
    val towns = readInt inStream
    val cars = readInt inStream
    val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
    fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
      | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(towns, cars, readInts cars [])
    end







fun transform (i, cararr, cars, cityarr) =
    if i=cars then cityarr

    else 
    let 
    val x=Array.sub(cararr,i)
    val y=Array.sub(cityarr,x)+1
    in 

    ( Array.update(cityarr,x,y); 
    transform ((i+1) ,cararr, cars, cityarr ))
    end 




fun next cityarr i towns dist flag  =
    if dist=0 then 
        next cityarr (i+1) towns 1 flag
    else
        if i=towns then
        next cityarr 0 towns (dist+1) 1

        else     
            if Array.sub(cityarr,i)<>0 then
                    towns-dist+flag
            else
            next cityarr (i+1) towns (dist+1) flag




    (* answer[0] ennow to sum kai answer[1] th thesh tou min !!! *)
fun loop cityarr cars towns i sum=
    if i= towns then sum-Array.sub(cityarr,0)*towns 
    else
    let 
    val x=(sum+Array.sub(cityarr,i)*(towns-i))
    in 
    loop cityarr cars towns (i+1) x
    end 


fun main cityarr cars towns i answer oldsum pos minsum =
    if i=0 then
        let 

        val x= loop cityarr cars towns 0 0 

        in
            main cityarr cars towns 1 answer x 0 x   

        end


    else 
        if i<towns then 
            let

            val sum = oldsum + cars -towns*Array.sub(cityarr, i )

            val nexti= (next cityarr i towns 0 0)
            val l=sum-nexti+1;


            in

            (* print("sum-nexti <= 2*nexti="^Int.toString (sum  + 1)^"<="^Int.toString (2*nexti) ^"\n"); *)
            if nexti <=l  then
            
                if sum<minsum then

                main cityarr cars towns (i+1) answer sum i sum
                else 
                main cityarr cars towns (i+1) answer sum pos minsum
            else 
                main cityarr cars towns (i+1) answer sum pos minsum
            
        
        
        end
        

        else ( Array.update(answer,0,minsum); Array.update(answer,1,pos);        
        print (Int.toString ( Array.sub(answer,0))^" "^Int.toString ( Array.sub(answer,1) ) ^"\n") ; answer  )



fun solve (towns, cars, cararr) =
    let
    val cararray =Array.fromList cararr
    val cityarr= Array.array(towns,0)
    val answer= Array.array(2,0)
    in 
        let 
        val cityarray = transform (0, cararray ,cars, cityarr )
        in 
            main cityarray cars towns 0 answer 1000000 0 10000000    
        end
    end

fun round fileName = solve (parse fileName) 