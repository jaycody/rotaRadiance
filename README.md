videoAlchemy
============

Processing and Arduino code for the Video Alchemy divination tool  
**testing git from sourceTree**

__________
		
##Contents:

####/controller // Arduino Code and Touch OSC layouts for three control devices:

1. **RadianceController**  // output = comma separated info from 7 potentiometers and 4 buttons
		- Mode_0 // all lights on

2. **FP-13-Controller**  // output = comma separated info from 10 potentiometers	

3. **iPadAlchemyController** // output = touchOSC


####/rota-Fortunae // Processing Code for the divination software and related diagnostic tools.

- **SystemCheckApps:**  // Diagonistic Processing Sketches  
	1. **QA-RadianceController** // diagostic tool for checking serial inputs from RadianceController  
	2. **QA-FP-13**  // diagostic tool in for checking serial inputs from FP-13  
	3. **QA-iPadAlchemyController** // diagnostic tool for checking touch OSC inputs from iPad
		

- **rota-Versions:** // organized by controller type  
	1. **rota-Radiance**  
	2.	**rota-FP-13**  
	3.	**rota-iPadAlchemyControl**  

________

###Photo Galleries:
[Emblems of Video Alchemy:  A Pattern Language] (http://www.flickr.com//photos/jaycody9/sets/72157627964989306/show/ "Flickr Gallery")  
[Video Alchemy @ Radiance Gallery : Sketches, Mockups, Install // Aug - Nov 2012] (https://www.dropbox.com/sh/90rs9db1xebfejy/bbzPMPqx-5)    
Radiance Gallery Exhibition // Nov - Dec 2012  

____________


###Projects
- **Video Alchemy:** 
	- emblems of interactive divination technologies
		a multimedia exhibit by jason stephens

		Radiance Art Gallery
		Oct 27 - Dec 10, 2012
		278 4th Street, Oakland CA

__________

###TODO:  
[x ] add a todo list


______________

###Notes:
- The Wheel of Fortune, or Rota Fortunae, is a concept in medieval and ancient philosophy referring to the capricious nature of Fate. The wheel belongs to the goddess Fortuna, who spins it at random, changing the positions of those on the wheel - 

_______________

###MultiMarkdown Syntax:  
	Link:
	An [example](http://url.com/ "Title")  
	# Github Style  
```
	js
	(rotaFunction(foo) {
		var name = "sup";
	});
	```
