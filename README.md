MailChecker2
============

This Electric Imp-powered device detects motion and reports it to you over the web.  It was originally designed to be stuck to a mailbox door
to notify you over WiFi when mail is delivered.  It could also be used to monitor doors (including garage or pet doors), valuables that you
don't want moved or cookie jars you want to keep children out of.

[![Poster](../master/production/Mailchecker2/poster.jpg?raw=true)](../master/production/Mailchecker2/poster-large.jpg?raw=true)

## Features

The board features an accelerometer, light sensor and Lithium-ion/polymer battery recharging built in.  It achieves approximately one month
of use between charges per 100mAh of battery capacity, assuming two motion activations per day.

This is a totally valid design but I intend to publish a newer version with Li-ion battery protection for unregulated cells.  The battery
attach terminals on the bottom are designed for a [138mAh Li-ion cell from HobbyKing](http://hobbyking.com/hobbyking/store/__37575__ZIPPY_138mAh_20C_Single_Cell_USA_Warehouse_.html),
which is an unregulated cell (and therefore can be fatally over-discharged by this design.)

## Board

[Order one from OSHPark](http://oshpark.com/shared_projects/IBBSjENY).

Submit the EAGLE sources or [gerber zip (Mailchecker2.zip)](../master/production/Mailchecker2) to your PCB fabricator to order your own.

## Parts

Check the [Bill of Materials](../master/production/Mailchecker2/Mailchecker2-parts.txt) to see what you already have that's an exact or close fit.
R1, R4 and R6 have important values.  All other resistors may be increased to 2x or decreased to 0.5x their specified value.
All capacitors may be increased of 2x their specified value.

## Assembly

[![Build diagram](../master/production/Mailchecker2/Mailchecker2-build-top.png?raw=true)](../master/production/Mailchecker2/Mailchecker2-build-top.pdf?raw=true)

## Firmware

Blink up the Imp and paste the squirrel source code in the [Electric Imp IDE](http://ide.electricimp.com).
