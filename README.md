# AI-BW-Image-Convertor
Converts black &amp; white images to colored images, all using AI DL

This project is working with Azure Functions and AI Deep Learning.
in order for it to work you need to create one Azure Function and use the Python code inside of it.
you can use the website in order to have a frontend to the client.

#Install Steps
1. Create Azure Funtion with Python support
2. Move all files in AI install folder into the D drive of the Function website folder.
3. Create Azure Stoge Blob for the files to be converted in and to, use the storage key and url and place then in the python code.
4. run the website frontend to controll the Azure Function trigger.
