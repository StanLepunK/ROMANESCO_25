##ROMANESCO version 25 / Romanesco Unu 1.0.0.25
Romanesco can be your manager to test your sketch in a P3D world.
This sketches are the final work for the first Romanesco Unu release.

##Architecture Sketches
* Romanesco : Sketch to set the Romanesco application.
* Controleur : interface slider to use the objects and the different parameters.
* Prescene : use to move the object in the 3D space.
* Scene : Display the result, we can use this one to send to syphon or not.

##Functions and variable
If you want code in Romanesco there few compulsory variables and functions that you can find in the file "Romanesco functions ##.txt" and others who can help you.

##Code and Export
* Create a new tab with a clean sub class "SuperRomanesco" in Prescene Sketch
* Give number ID to this one, this number must be in the series of the other. No interruption from the first Obj ID to the last ID.
* When your code is done, run the Prescene to create the index of yours objects in the folder "Prescene-#/preferences/objects" paste this one in the to the folder "Controleur-#/preferences/objects".
* Change or add a thumbnail for your object "Controleur_##/data/thumbnail/.../name+IDnumber+png" there is 4 pic for each object. Size 22x22 pixel in png mode. To help, you can use the illustrator file : picto
* Run the sketch Controleur
* If your code work fine, you can past your brick in the folder "Scene-#"
* Export all your Apps, put the "Launcher.app" them at the root, in the same folder create a folder "source", in this one you can drop the Scene, Prescene and the Controleur dont forget to create the folder "preferences" and put in this one every data you need.
* it's done !




##LICENCE
ROMANESCO is under the licence CeCILL.
Romanesco is free for the non-commercial use in other case contact-me.
2011-2014.
