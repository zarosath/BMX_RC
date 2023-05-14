Local repeated:Int

'camera variables
Local cameraX:Float
Local cameraY:Float
Local cameraZ:Float
Local PlayerX:Float
Local PlayerY:Float
Local PlayerZ:Float
Local cameraPitch:Float
Local cameraYaw:Float
Local cameraDist:Float
Local DesiredX:Float
Local DesiredY:Float
Local DesiredZ:Float
Local ActualX:Float
Local ActualY:Float
Local ActualZ:Float
Local camera:Tcamera=Createcamera()
'cameraera
PositionEntity camera,130,1,-130

Function camera()
		' Ugly hack To allow repetion of cameraera positioning If cameraera ends up too close To the player (see below)
		Repeated = False
		#cameraRepeat
		' Find desired camera position in Global units
		cameraX = EntityX(camera)
		cameraY = EntityY(camera)
		cameraZ = EntityZ(camera)
		PlayerX = EntityX(Player)
		PlayerY = EntityY(Player) + cameraHeight#
		PlayerZ = EntityZ(Player)
		PositionEntity(camera, PlayerX, PlayerY, PlayerZ)
		RotateEntity(camera, cameraPitch, cameraYaw + EntityYaw(Player) + 180.0, 0.0)
		MoveEntity(camera, 0.0, 0.0, -cameraDist)
		DesiredX = EntityX(camera)
		DesiredY = EntityY(camera) + 1.5
		DesiredZ = EntityZ(camera)
		; camera collision with scenery (ensure player is always visible)
		Result = LinePick(PlayerX#, PlayerY#, PlayerZ#, DesiredX# - PlayerX#, DesiredY# - PlayerY#, DesiredZ# - PlayerZ#)
		If Result <> 0
			DesiredX = PickedX()
			DesiredY = PickedY()
			DesiredZ = PickedZ()
		EndIf
		; Smoothly move camera towards the desired position
		ActualX = cameraX + (((DesiredX - cameraX) / 6.0) * Delta)
		ActualY = cameraY + (((DesiredY - cameraY) / 6.0) * Delta)
		ActualZ = cameraZ + (((DesiredZ - cameraZ) / 6.0) * Delta)
		PositionEntity(camera, ActualX, ActualY, ActualZ)
		PositionEntity(playerpivot, PlayerX, PlayerY, PlayerZ)
		PointEntity(camera, playerpivot)
		; If the camera has collided, move it forwards so it doesn't clip the object
		If Result <> 0 Then MoveEntity(camera, 0.0, 0.0, 0.1)
		; Flip camera 180 degrees If pushed too close To the player by a wall (prevents flickering)
		PositionEntity(playerpivot, DesiredX, DesiredY, DesiredZ)
		If EntityDistance#(playerpivot, head) < 2.0 And Repeated = False
			cameraYaw = cameraYaw + 180.0
			Repeated = True
			Goto cameraRepeat
			Return
		EndIf
End Function