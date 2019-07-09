![alt text](https://armiev.com/wp-content/uploads/2019/03/bwlogo-150x150.png)

# AI-BW-Image-Convertor
Converts black &amp; white images to colored images, all using AI DL

This project is working with Azure Functions and AI Deep Learning.
in order for it to work you need to create one Azure Function and use the Python code inside of it.
you can use the website in order to have a frontend to the client.

This solution is working by entegration CNN 
![alt text](https://armiev.com/wp-content/uploads/2019/03/bw_colorization_opencv_arch.png)

if you need more information about CNN then go to the next link:
[GitHub Pages](http://richzhang.github.io/colorization/)

## PreReq Steps
1. Create Azure Funtion with Python support
2. Move all files in AI install folder into the D drive of the Function website folder.
3. Create Azure Stoge Blob for the files to be converted in and to, use the storage key and url and place then in the python code.
4. run the website frontend to controll the Azure Function trigger.


## Step 1
Create Azure Function with whatever triger you want but do select python as your languge.
the best way is to start a project in VSCode of Azure Functions with Python.

When created and published you need to go to the Azure Function Kudu tool. 
then the Function App name on the left, then Platform features at the top, and then "Advanced tools (Kudu)".
update the Python version, click the Site extensions at the top.
and then the Gallery tab. Then type in Python in the search. The results will provide multiple versions of Python available to be installed. Pick your desired version. 

Select the 3.6-7 version and 

##  Step 2
As you have the function deployed and the python install, all you need is a working deployment for the file input
i created a website that you can upload images to and it will upload the photos to the Azure Blob that in term will
triger the Azure Function.

### Notes:
Its importent to node that in Azure Function like in all webapp application you run the applicatoin in D drive and 
note that in your scripts and paths you create.

you will need to provide an input:

![alt text](https://armiev.com/wp-content/uploads/2019/03/BWexmapleBW-300x200.jpg)

and the function will provide an output, select the location where you want the output to go, in my case i used Blob but you can select 
what ever you need for your project

![alt text](https://armiev.com/wp-content/uploads/2019/03/BWexmapleReColor-300x200.jpg)

this is the original just to compare:

![alt text](https://armiev.com/wp-content/uploads/2019/03/BWexmapleColor-300x200.jpg)
