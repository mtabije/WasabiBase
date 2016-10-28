//All our base are belong to us

/* [Basic] */

//Parts to Print
selectedParts = 4; //[1: Base Only, 2: Ability Clip, 3: Level Clip, 4: Base and Clip(s)]

//Size of the bottom of the top of the Base (flat side to flat side)
topBaseWidth = 30;

//Size of the bottom of the base
baseEdgeWidth = 4;  //DEV/BUG edge width cannot be less than 5, fix this

//Thickness of the base
baseHeight = 5; //Must be greater than 5

ability = "Sneak";  //[Range, Basic, Sneak]

level = 5; //Max 6

/* [Advanced] */

//Width of the Symbol Clip
symbolClipWidth = 7;
symbolHeight = 2.7;  // DEV/BUG - Issues with changing this need to parameticize the callign function

//Distance from the corner of the top hex the symbol clip starts
levelClipOffset = 1;

clipTolerance = .15;  //Horizontal Tolerance
clipVerticalTolerance = .25;
clipBandHeight = 1.5;

levelSymbolWidth = 2.5;  //This is not 100% parametricized
levelSymbolSpacing = 2.5;  //This is not 100% parametricized
levelSymbolOverhang = 1.5; //How much the level symbols stick out from the base.

lipHeight = .5;
lipOverhang = .2;

/* [Hidden] */

bottomBaseWidth = topBaseWidth + baseEdgeWidth*2;

dochTop = 2 * topBaseWidth / sqrt(3); //diameter of circle around Hex (DOCH)
dochBottom = 2 * bottomBaseWidth / sqrt(3); //diameter of circle around Hex (DOCH)
topHexSideLen = topBaseWidth / sqrt(3); //Length of the top Hex's side

edgeAngle = atan2(baseHeight-.5,baseEdgeWidth);

//*** Main ****

if(selectedParts == 4 || selectedParts == 1)
{
        
    //Main Base
    difference()
    {
        
        union()
        {
            translate([0,0,.5])
                cylinder(h=baseHeight-.5, r2=dochTop/2, r1=dochBottom/2,  $fn = 6);
                cylinder(h=.5, r=dochBottom/2,  $fn = 6);
        }
        //Material Removeal
        
            //Symbol Clip Area Removal 
            
            translate([-(symbolClipWidth+clipTolerance*2)/2, topBaseWidth/2-clipTolerance, 0])
                cube([symbolClipWidth+clipTolerance*2 , baseEdgeWidth+clipTolerance, baseHeight]);
            translate([-(symbolClipWidth+clipTolerance*2)/2,-topBaseWidth/2,0])
                cube([symbolClipWidth+clipTolerance*2, clipTolerance+.5, baseHeight]);
            //Lip 
            translate([-(symbolClipWidth+clipTolerance*2)/2, -topBaseWidth/2+.5, baseHeight-lipHeight-clipVerticalTolerance])     
                cube([symbolClipWidth+clipTolerance*2, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
            
            mirror([0,1,0])
            {
                translate([-(symbolClipWidth+clipTolerance*2)/2, topBaseWidth/2-clipTolerance, 0])
                    cube([symbolClipWidth+clipTolerance*2 , baseEdgeWidth+clipTolerance, baseHeight]);
                translate([-(symbolClipWidth+clipTolerance*2)/2,-topBaseWidth/2,0])
                cube([symbolClipWidth+clipTolerance*2, clipTolerance+.5, baseHeight]);
                //Lip 
                translate([-symbolClipWidth/2, -topBaseWidth/2+.5, baseHeight-lipHeight])     
                    cube([symbolClipWidth, lipOverhang, lipHeight]);
                  //Lip 
                translate([-(symbolClipWidth+clipTolerance*2)/2, -topBaseWidth/2+.5, baseHeight-lipHeight-clipVerticalTolerance])     
                    cube([symbolClipWidth+clipTolerance*2, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
            }
            
            //Level Clip Area Removal 
            
            union()  //DEV/BUG  this uses an arbitrary value to remove extra material see ".6"
            {
                rotate([0,0,-60])
                    union()
                    {
                        //Polygon Plus .5 Side Thickening cube
                        translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(clipTolerance+.5), 0])
                            cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+clipTolerance+.6, baseHeight]);
                        //Lip 
                        translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang+clipTolerance), baseHeight-lipHeight-clipVerticalTolerance])     
                            cube([topHexSideLen-levelClipOffset, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
                    }
                    
                mirror([0,1,0])
                    rotate([0,0,-60])
                        union()
                        {
                            //Polygon Plus .5 Side Thickening cube
                            translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(clipTolerance+.5), 0])
                                cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+clipTolerance+.6, baseHeight]);
                            //Lip 
                            translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang+clipTolerance), baseHeight-lipHeight-clipVerticalTolerance])     
                                cube([topHexSideLen-levelClipOffset, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
                        }  
                        
                mirror([1,0,0])
                    rotate([0,0,-60])
                        union()
                        {
                            //Polygon Plus .5 Side Thickening cube
                            translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(clipTolerance+.5), 0])
                                cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+clipTolerance+.6, baseHeight]);
                            //Lip 
                            translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang+clipTolerance), baseHeight-lipHeight-clipVerticalTolerance])     
                                cube([topHexSideLen-levelClipOffset, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
                        }  
                        
                mirror([1,0,0])        
                    mirror([0,1,0])
                        rotate([0,0,-60])
                            union()
                            {
                                //Polygon Plus .5 Side Thickening cube
                                translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(clipTolerance+.5), 0])
                                    cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+clipTolerance+.6, baseHeight]);
                                //Lip 
                                translate([-((topHexSideLen+clipTolerance*2)/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang+clipTolerance), baseHeight-lipHeight-clipVerticalTolerance])     
                                    cube([topHexSideLen-levelClipOffset, lipOverhang+clipTolerance, lipHeight+clipVerticalTolerance]);
                            }  
            }
            
            //Material Removal to help droopy corners at Level Clip edge
            //DEV/BUG - This is not parametric.
            rotate([0,0,90])
                translate([-(symbolClipWidth/2+clipTolerance), topBaseWidth/2-baseEdgeWidth/2-clipTolerance-.2, 0])
                    prism(symbolClipWidth+clipTolerance*2, baseEdgeWidth+.2, baseHeight-1); 
                    
            rotate([0,0,-90])
                translate([-(symbolClipWidth/2+clipTolerance), topBaseWidth/2-baseEdgeWidth/2-clipTolerance-.2, 0])
                    prism(symbolClipWidth+clipTolerance*2, baseEdgeWidth+.2, baseHeight-1); 
            
            
            //Symbol Clip Bands Removal
            translate([-(symbolClipWidth+clipTolerance*2)/2, -bottomBaseWidth/2, 0])
                cube([symbolClipWidth+clipTolerance*2, bottomBaseWidth, clipBandHeight*2 + clipVerticalTolerance]);
                
            rotate([0,0,90])
                translate([-(symbolClipWidth+clipTolerance*2)/2, -bottomBaseWidth/2, 0])
                cube([symbolClipWidth+clipTolerance*2, bottomBaseWidth, clipBandHeight + clipVerticalTolerance]);
                
    }
}


if(selectedParts == 4 || selectedParts == 2)
{

    //Symbol Clip
    translate([25,0,0]) //DEV/BUG - Parametric This
    {
       //Clip Band
        translate([-(symbolClipWidth)/2, -topBaseWidth/2, clipBandHeight+clipVerticalTolerance])
            cube([symbolClipWidth, topBaseWidth, clipBandHeight-clipVerticalTolerance]);
        
        //Clip Sides
        translate([-symbolClipWidth/2, -bottomBaseWidth/2, .5])
            prism(symbolClipWidth, baseEdgeWidth, baseHeight-.5); 
        translate([-symbolClipWidth/2, -bottomBaseWidth/2, 0])
            cube([symbolClipWidth, baseEdgeWidth, .5]);
        translate([-symbolClipWidth/2,-topBaseWidth/2,0])
            cube([symbolClipWidth, .5, baseHeight]);
        translate([-symbolClipWidth/2,-topBaseWidth/2,0])
            cube([symbolClipWidth, topBaseWidth/2-symbolClipWidth/2-clipTolerance, clipBandHeight+clipVerticalTolerance]);
        //Lip 
        translate([-symbolClipWidth/2, -topBaseWidth/2+.5, baseHeight-lipHeight])     
            cube([symbolClipWidth, lipOverhang, lipHeight]);
        
        mirror([0,1,0])
        {
            translate([-symbolClipWidth/2, -bottomBaseWidth/2, .5])
                prism(symbolClipWidth, baseEdgeWidth, baseHeight-.5); 
            translate([-symbolClipWidth/2, -bottomBaseWidth/2, 0])
                cube([symbolClipWidth, baseEdgeWidth, .5]);
            translate([-symbolClipWidth/2,-topBaseWidth/2,0])
                cube([symbolClipWidth, .5, baseHeight]);
            translate([-symbolClipWidth/2,-topBaseWidth/2,0])
                cube([symbolClipWidth, topBaseWidth/2-symbolClipWidth/2-clipTolerance, clipBandHeight+clipVerticalTolerance]); 
            //Lip 
            translate([-symbolClipWidth/2, -topBaseWidth/2+.5, baseHeight-lipHeight])     
                cube([symbolClipWidth, lipOverhang, lipHeight]);
        }
        
        // clipSymbol
        //DEV/BUG edge width cannot be less than 5, fix this... Make this more parametric... Need to fix angle and height
     
        translate([0, -bottomBaseWidth/2+symbolHeight/2+1, symbolHeight-.5])
            rotate([edgeAngle,0,0])
                abilitySymbol(symbolClipWidth-2, symbolHeight, ability);
        
        mirror([0,1,0])
            translate([0, -bottomBaseWidth/2+symbolHeight/2+1, symbolHeight-.5])
                rotate([edgeAngle,0,0])
                    abilitySymbol(symbolClipWidth-2, symbolHeight, ability);
    } 
    
}


if(selectedParts == 4 || selectedParts == 3)
{
    //Level Clip       
    translate([-40,0,0]) //DEV/BUG Parametric This
    {
        //Clip Band
        rotate([0,0,90])
            translate([-(symbolClipWidth)/2, -dochTop/2, 0])
                cube([symbolClipWidth, dochTop, clipBandHeight]);
   
        //Clip Sides
        intersection()
        {
            union()
            {
                translate([0,0,.5])
                    cylinder(h=baseHeight-.5, r2=dochTop/2, r1=dochBottom/2,  $fn = 6);
                cylinder(h=.5, r=dochBottom/2,  $fn = 6);
            }
            
            union()
            {
           
                          
                rotate([0,0,-60])
                    union()
                    {
                        //Thicken side poly
                        translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-.5, 0])
                            cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+.5, baseHeight]);
                        //Lip 
                        translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang), baseHeight-lipHeight])     
                            cube([topHexSideLen-levelClipOffset, lipOverhang, lipHeight]);
                     }
               
                mirror([0,1,0])
                    rotate([0,0,-60])
                        union()
                        {
                            //Thicken side poly
                            translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-.5, 0])
                                cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+.5, baseHeight]);
                        
                            //Lip
                            translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang), baseHeight-lipHeight])     
                                cube([topHexSideLen-levelClipOffset, lipOverhang, lipHeight]);
                        }
                            
                            
                mirror([1,0,0])
                    rotate([0,0,-60])
                    union()
                    {
                        //Thicken side poly
                        translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-.5, 0])
                            cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+.5, baseHeight]);
                        //Lip 
                        translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang), baseHeight-lipHeight])     
                            cube([topHexSideLen-levelClipOffset, lipOverhang, lipHeight]);
                     }
                     
                mirror([1,0,0])        
                    mirror([0,1,0])
                        rotate([0,0,-60])
                             union()
                            {
                                //Thicken side poly
                                translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-.5, 0])
                                    cube([topHexSideLen+baseEdgeWidth, baseEdgeWidth+.5, baseHeight]);
                                //Lip 
                                translate([-(topHexSideLen/2-levelClipOffset), topBaseWidth/2-(.5+lipOverhang), baseHeight-lipHeight])     
                                    cube([topHexSideLen-levelClipOffset, lipOverhang, lipHeight]);
                             }
                
                }
            }
            
            //Level Symbols
            levelStartLoc=-(topHexSideLen/2-levelClipOffset);
            levelLocInc=levelSymbolSpacing+levelSymbolWidth;
            
           
            //DEV/BUG This is not 100% parametric

        difference()
        {
            union()
            {
                if(level >= 1)
                {
                
                    rotate([0,0,-120])
                        translate([levelStartLoc,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-120])
                            translate([levelStartLoc,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                if(level >= 2)
                {
                    rotate([0,0,-120])
                        translate([levelStartLoc+levelLocInc,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-120])
                            translate([levelStartLoc+levelLocInc,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                if(level >= 3)
                {
                
                    rotate([0,0,-120])
                        translate([levelStartLoc+levelLocInc*2,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-120])
                            translate([levelStartLoc+levelLocInc*2,-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                if(level >= 4)
                {
                
                    rotate([0,0,-60])
                        translate([-(levelStartLoc+levelLocInc*2+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-60])
                            translate([-(levelStartLoc+levelLocInc*2+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                if(level >= 5)
                {
                
                    rotate([0,0,-60])
                        translate([-(levelStartLoc+levelLocInc+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-60])
                            translate([-(levelStartLoc+levelLocInc+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                if(level >= 6)
                {
                
                    rotate([0,0,-60])
                        translate([-(levelStartLoc+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                            cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                    
                    mirror([1,0,0])mirror([0,1,0])
                        rotate([0,0,-60])
                            translate([-(levelStartLoc+levelSymbolWidth),-(bottomBaseWidth/2+levelSymbolOverhang),0])
                                cube([levelSymbolWidth, baseEdgeWidth+levelSymbolOverhang, baseHeight]);
                }
                
                
                
            }  //end of union
            
            union()
            {
           
                //Blocks to remove the corners of the level pieces. 
               
                
                //Dev-Bug may need to make this more parametric
                rotate([0,0,-60])
                        translate([-topHexSideLen/2, -(topBaseWidth/2+baseEdgeWidth+levelSymbolOverhang), baseHeight/2+.5])
                            rotate([edgeAngle,0,0])
                                cube([topHexSideLen, baseEdgeWidth, baseHeight/2]);
               
                 rotate([0,0,-120])
                        translate([-topHexSideLen/2, -(topBaseWidth/2+baseEdgeWidth+levelSymbolOverhang), baseHeight/2+.5])
                            rotate([edgeAngle,0,0])
                                cube([topHexSideLen, baseEdgeWidth, baseHeight/2]);
               
                rotate([0,0,60])
                        translate([-topHexSideLen/2, -(topBaseWidth/2+baseEdgeWidth+levelSymbolOverhang), baseHeight/2+.5])
                            rotate([edgeAngle,0,0])
                                cube([topHexSideLen, baseEdgeWidth, baseHeight/2]);
               
                rotate([0,0,120])
                        translate([-topHexSideLen/2, -(topBaseWidth/2+baseEdgeWidth+levelSymbolOverhang), baseHeight/2+.5])
                            rotate([edgeAngle,0,0])
                                cube([topHexSideLen, baseEdgeWidth, baseHeight/2]);
                
            }
            
            
            
            
            
        }  //end of difference
    }
}



//*** Modules ****
module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module abilitySymbol(abilitySize, abilityHeight, ability)
{
    echo("Ability Symbol Size =", abilitySize);
    
    //Range - Triangle
    if(ability == "Range")   
            linear_extrude(height=abilityHeight)
                polygon([[-abilitySize/2,-abilitySize/2],[0,abilitySize/2],[abilitySize/2,-abilitySize/2]]);

    //Direct - Square
    if(ability == "Basic")
        translate([0, 0, abilityHeight/2])  //setting cube to be center set and start at Z=0
            cube([abilitySize, abilitySize, abilityHeight], center=true);

    //Sneak - Circle
    if(ability == "Sneak")
       cylinder(h=abilityHeight,r=abilitySize/2);
    
  
       
}


