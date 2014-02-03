#ROMANESCO PROJECT
###Generative Live Art Application
Romanesco is community project to share, see, export the creative code from Processing

####Three main sketches :
Controleur, Prescene, and Scene
####One annexe sketch :
Miroir

The controler is a specific sketch, 
but the prescene, scene and mirroir are very similare.

The main sketch is the Prescene, the Scene and Mirroir is a replic of this one.

The Controleur send information to the Prescene about the different instruction that prescene must be execute, 
the Prescene execute all the instruction, and add few instructions like the mouse position, sound effect...
then send all informations to the Scene or the Mirroir for the final work.

Between the Prescene, Scene there are a commom tabs :
Object, Camera, SuperRomanesco


Between the Prescene and Miroir
same
P3D tab, Super Romanesco
for the tabs objects is very close you must add the command "mirroir.function()" before all the graphic functiun like
ellipse, rect, line, point, set, translateXYZ, rotateXYZ, scale, fill, noFill, stroke, noStroke, strokeWeight,text, beginShape, endShape, vertex, box, sphere, quad, popMatrix, pushMatrix, applyMatrix...
becareful the miroir. don't work with Pmatrix3D() !


######Soon I prepare a Startcoding Sketch to make easier the objects coding.
##LICENCE
ROMANESCO alpha 24 is under the licence CeCILL, very similar to the GNU GPL licence.
