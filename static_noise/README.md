This is a unoptimized generation of "static." Basically just generate a random color for every frame each draw cycle. It's pretty slow and intensive. To make this better you can try to create a buffer of x colors for each pixel each frame and cycle through 1 color every frame. What I don't know if it's thats just going to look like a white screen because I'd imagine the colors will be changining so fast your monitor will be able to pick up each frame. Maybe instead you should try to find the refresh rate of the monitor and limit the fps to something smaller. I'd say 60hz static would be a good option most monitors if you dont want to trouble yourself with grabbing hardware related data.

What the data file is doing is storing the the window position from the previous use and moving it back to where it was when the program starts. There is a bug though the window tends to render before moving doesnt look very nice. data can be used to hold any number of elements could hold save data, settings, debug info, or anything else.

I haven't determined how to run love with a console for debug information yet.


![alt text](static.gif)
