// Configureable Miniature Hex Base
//  For Wasabi Minature Wargame
//  Created by Mark Tabije
//  Designed by Brian Coley, Mike Warner, and Mark Tabije
//  See Thingiverse.com for lisencing information.

// Size of the Model Base in mm (flat side to flat side).
modelBaseSize = 38;

//[Hidden]
hexAngles = [ for (i = [0 : 60 : 330]) i ];

for(i = hexAngles)
{    
    rotate([0,0,i])
        polygon([[-(modelBaseSize/sqrt(3))/2,-modelBaseSize/2],[0,0],[(modelBaseSize/sqrt(3))/2,-modelBaseSize/2]]);
};