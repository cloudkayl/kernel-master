#! /bin/csh -f

# Usage: gen.sh
# Creates <i1>{List,ListSort}.{i3,m3} for <i1> in {Atom,Int,Ref,Text}
# and appends corresponding lines to m3makefile

echo "" >> m3makefile
foreach i1 (Atom Int Ref Text)
    set e1=$i1
    if("$e1" == "Int") set e1=Integer
    if("$e1" == "Ref") set e1=Refany
    set b=${i1}List
    echo "(* Copyright 1993 Digital Equipment Corporation. *)" > $b.i3
    echo "(* Distributed only by permission. *)"               >>$b.i3
    echo "(* Last modified on `date` by $USER *)"              >>$b.i3
    echo " "                                                   >>$b.i3
    echo "INTERFACE ${i1}List = List($e1) END ${i1}List."      >>$b.i3
    echo "(* Copyright 1993 Digital Equipment Corporation. *)" > $b.m3
    echo "(* Distributed only by permission. *)"               >>$b.m3
    echo "(* Last modified on `date` by $USER *)"              >>$b.m3
    echo " "                                                   >>$b.m3
    echo "MODULE ${i1}List = List($e1) END ${i1}List."         >>$b.m3
    echo "Module(${i1}List)" >> m3makefile

    set b=${i1}ListSort
    echo "(* Copyright 1993 Digital Equipment Corporation. *)" > $b.i3
    echo "(* Distributed only by permission. *)"               >>$b.i3
    echo "(* Last modified on `date` by $USER *)"              >>$b.i3
    echo " "                                                   >>$b.i3
    echo "INTERFACE ${i1}ListSort = ListSort($e1, ${i1}List) END ${i1}ListSort." >>$b.i3
    echo "(* Copyright 1993 Digital Equipment Corporation. *)" > $b.m3
    echo "(* Distributed only by permission. *)"               >>$b.m3
    echo "(* Last modified on `date` by $USER *)"              >>$b.m3
    echo " "                                                   >>$b.m3
    echo "MODULE ${i1}ListSort = ListSort($e1) END ${i1}ListSort." >>$b.m3
    echo "Module(${i1}ListSort)" >> m3makefile
end
