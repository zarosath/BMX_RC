
'main program
Strict

Framework openb3d.b3dglgraphics
Import "cameraFunctions.bmx"
Graphics3D 800,600, 0, 3

Include "Player_RC.bmx"
Include "Create_terrain.bmx"
Include "Camera_RC.bmx"
Global Delta:Float
' Light the world, todo;maybe put the lighting in bmx zone file. for now it is in main.
Local light:TLight=CreateLight()
RotateEntity light,90,0,0



While Not KeyDown( KEY_ESCAPE )
'cam()

RenderWorld

Text 0,0,"Use cursor keys to move about the terrain"

Flip(1)


Wend

