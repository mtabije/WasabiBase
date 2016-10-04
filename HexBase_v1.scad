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

// Ability for the Clip
baseClipAbility = "Range";  //[Range, Direct, Sneak, All]


//[Hidden]




/*difference()
{
    //Base Shell
    makeHex(baseSize, baseThickness);
    
    //Model Base (removed from Base Shell)   
    translate([0,0,(baseThickness-modelBaseThickness)])makeHex(modelBaseSize, modelBaseThickness); */
    
    //Removing material for Ability clip
    rotate([0,0,-30])
        sideAbilityClip(baseSize, 10, baseThickness, 2, (baseSize-modelBaseSize+1)/2, 0.5, 1, baseClipAbility);
        
   
//};


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

module sideAbilityClip(clipLength, clipWidth, clipAbilityThickness, clipBandThickness, clipAbilityWidth, clipLipWidth, clipLipThickness, clipAbility)
{
    union()
    {
        //Bottom Band
       translate([-clipLength/2,-clipWidth/2,0])
            cube([clipLength, clipWidth, clipBandThickness]);
       
               
        //Left Ability Clip
        translate([-clipLength/2,-clipWidth/2,0])
            union()
            {   
                //Vertical Clip Piece
                cube([clipAbilityWidth, clipWidth, clipAbilityThickness]);
                        
                //Clip Lip
                translate([0, 0, clipAbilityThickness])
                    cube([clipAbilityWidth+clipLipWidth, clipWidth, clipLipThickness]);
            
                //Ability Symbol
                translate([clipAbilityWidth/2, clipWidth/2, clipAbilityThickness+clipLipThickness])
                    abilitySymbol(clipAbilityWidth, 2, clipAbility);
                
            };
                
                
       
        //Right Ability Clip
        mirror([1,0,0])
        {
            translate([-clipLength/2,-clipWidth/2,0])
                union()
                {   
                    //Vertical Clip Piece
                    cube([clipAbilityWidth, clipWidth, clipAbilityThickness]);
                            
                    //Clip Lip
                    translate([0, 0, clipAbilityThickness])
                        cube([clipAbilityWidth+clipLipWidth, clipWidth, clipLipThickness]);
                
                    //Ability Symbol
                    translate([clipAbilityWidth/2, clipWidth/2, clipAbilityThickness+clipLipThickness])
                        abilitySymbol(clipAbilityWidth, 2, clipAbility);
                    
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
