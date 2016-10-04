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
baseSize = 46;

// Thickness of the Base in mm.
baseThickness = 7;



//[Hidden]




difference()
{
    //Base Shell
    makeHex(baseSize, baseThickness);
    
    //Model Base (removed from Base Shell)   
    translate([0,0,(baseThickness-modelBaseThickness)])makeHex(modelBaseSize, modelBaseThickness);
    
    //Removing material for attribute clip
    rotate([0,0,-30])
        sideAttributeClip(baseSize, 10, baseThickness, 2, (baseSize-modelBaseSize+1)/2, 1);
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
        translate([-clipLength/2,-clipWidth/2,0])
            cube([clipLength,clipWidth,clipBandThickness]);
       
        //Left Attribute Clip
        translate([-clipLength/2,-clipWidth/2,clipBandThickness])
            cube([clipAttributeWidth,clipWidth,clipAttributeThickness]);
       
        //Right Attribute Clip
        translate([clipLength/2-clipAttributeWidth,-clipWidth/2,clipBandThickness])
            cube([clipAttributeWidth,clipWidth,clipAttributeThickness]);
    };
    
    
};