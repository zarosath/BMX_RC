' load player mesh
Local Player:TMesh=LoadAnimMesh("Media/models/Player/player.b3d")
ScaleEntity Player,1,1,1
Local playerpivot:tpivot=CreatePivot()
Local head:tentity = FindChild(player, "Head")