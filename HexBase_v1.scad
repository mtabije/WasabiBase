// Configureable Miniature Hex Base
//  For Wasabi Minature Wargame
//  Created by Mark Tabije
//  Designed by Brian Coley, Mike Warner, and Mark Tabije
//  See Thingiverse.com for lisencing information.

//Defaults based on Knight Model

// Size of the Model Base in mm (flat side to flat side).
modelBaseSize = 31;

// Thickness of the Model Base in mm.
modelBaseThickness = 6.5;

// Size of the Base in mm (flat side to flat side; typically 8mm larger than modelBaseThickness).
baseSize = 39;

// Thickness of the Base in mm.  (typically modelBaseSize + Clip Band Thickness + 3mm)
baseThickness = 11;

// Ability for the Clip
baseClipAbility = "Range";  //[Range, Direct, Sneak, All]


//[Advanced]

abilityClipWidth = 10;
abilityClipBandThickness = 1.5;
lipOverhang = 0.5;
lipOverhangThickness = 1;
clipTolerance = 0.25;
symbolThickness = 1.5;



difference()
{
    //Base Shell
    makeHex(baseSize, baseThickness);
    
    //Model Base (removed from Base Shell)   
    translate([0,0,(baseThickness-modelBaseThickness)])makeHex(modelBaseSize, modelBaseThickness);
    
    //Removing material for Ability clip
    rotate([0,0,-30])
        sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize+1)/2, lipOverhang, lipOverhangThickness, baseClipAbility);
        
   
};


module makeHex(shapeWidth, thickness)
{
    hexAngles = [ for (i = [0 : 60 : 300]) i ];
    
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


//Original: sideAbilityClip(clipLength, clipWidth, clipAbilityThickness, clipBandThickness, clipAbilityWidth, clipLipWidth, clipLipThickness, clipAbility) 
module sideAbilityClip(clipLength, clipWidth, clipSideThickness, clipBottomBandThickness, clipSideWidth, clipLipWidth, clipLipThickness, clipAbility)
{
    union()
    {
       
       //Bottom Band
       translate([-clipLength/2,-clipWidth/2,0])
            cube([clipLength, clipWidth, clipBottomBandThickness]);
                      
        //Left Side of Clip
        translate([-clipLength/2,-clipWidth/2,0])
            union()
            {   
                //Vertical Clip Piece
                cube([clipSideWidth, clipWidth, clipSideThickness]);
                        
                //Clip Lip
                translate([0, 0, clipSideThickness])
                    cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);
            
                //Ability Symbol
                translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipThickness])
                    abilitySymbol(clipSideWidth, symbolThickness, clipAbility);
                
            };
       
        //Right Side Clip
        mirror([1,0,0])
        {
            translate([-clipLength/2,-clipWidth/2,0])
                union()
                {   
                    //Vertical Clip Piece
                    cube([clipSideWidth, clipWidth, clipSideThickness]);

                    //Clip Lip
                    translate([0, 0, clipSideThickness])
                        cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);

                    //Ability Symbol
                    translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipThickness])
                        abilitySymbol(clipSideWidth, 2, clipAbility);

                };
        };
            
    
        
    };
    
    
};

module abilitySymbol(abilitySize, abilityThickness, ability)
{
    echo("Ability Symbol Size =", abilitySize);
    
    //Range - Triangle
    if(ability == "Range")
        rotate([0,0,-90])
            linear_extrude(height=abilityThickness)
                polygon([[-abilitySize/1.5,-abilitySize/2],[0,abilitySize/2],[abilitySize/1.5,-abilitySize/2]]);

    //Direct - Square
    if(ability == "Direct")
        translate([0, 0, abilityThickness/2])  //setting cube to be center set and start at Z=0
            cube([abilitySize, abilitySize, abilityThickness], center=true);

    //Sneak - Circle
    if(ability == "Sneak")
       cylinder(h=abilityThickness,r=abilitySize/2);
    
    
};
