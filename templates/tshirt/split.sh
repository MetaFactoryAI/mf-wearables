#!/bin/bash

#convert "$1" +repage -gravity south -crop 100x50% +repage -gravity east +append out/"$1"

#convert"$1" -crop 100x50% +repage -gravity north -crop 100x50% +repage -gravity east +append out/"$1"


#convert "$1" -crop 100%x50% +repage -gravity east +append out/"$1"


#convert "$1" -crop 50%x100% +repage -gravity east +append out/"$1"



#convert "$1" crop 50%x100% +repage -gravity east +append out/"$1"
#convert "$1" -crop 100%x50% out/"$1"
#convert "$1" -crop 50%x100% +repage -gravity east +append out/"$1"
#convert "$1" -gravity East -crop 2x1@ +repage +append out/"$1"



convert "$1" -crop 100%x50% +repage  -gravity east -background none -splice 0x0 +append out/"$1"
