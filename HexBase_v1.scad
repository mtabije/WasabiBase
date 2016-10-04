// Configureable Miniature Hex Base
//  For Wasabi Minature Wargame
//  Created by Mark Tabije
//  Designed by Brian Coley, Mike Warner, and Mark Tabije
//  See Thingiverse.com for lisencing information.

// Size of the Model Base in mm (flat side to flat side).
modelBaseSize = 38;

// Thickness of the Model Base in mm.
modelBaseThickness = 3;

// Size of the Base in mm (flat side to flat side).
baseSize = 44;

// Thickness of the Base in mm.
baseThickness = 6;



//[Hidden]

difference()
{
    //Base Shell
    makeHex(baseSize, baseThickness);
    
    //Model Base (removed from Base Shell)   
    translate([0,0,(baseThickness-modelBaseThickness)])makeHex(modelBaseSize, modelBaseThickness);
    
    //Removing material for attribute clip
};


module makeHex(shapeWidth, thickness)
{
    hexAngles = [ for (i = [0 : 60 : 330]) i ];
    
        linear_extrude(height = thickness)
        {
            hull()
            {
                for(i = hexAngles)
                {    
                    rotate([0,0,i])
                        polygon([[-(shapeWidth/sqrt(3))/2,-shapeWidth/2],[0,0],[(shapeWidth/sqrt(3))/2,-shapeWidth/2]]);
                };
            };
        };
};

module sideAttributeClip(clipLength, clipWidth, clipAttributeThickness, clipBandThickness, clipAttributeWidth, clipAttribute)
{
    union()
    {
        //Bottom Band
        cube([clipWidth,clipLength,clipBandThickness]);
       
        //Left Attribute Clip
        translate([-clipLength/2,0,clipBandThickness])
            cube([clipWidth,clipAttributeWidth,clipAttributeThickness]);
       
        //Right Attribute Clip
        translate([clipLength/2-clipAttributeWidth,0,clipBandThickness])
            cube([clipWidth,clipAttributeWidth,clipAttributeThickness]);
    };
    
    
};