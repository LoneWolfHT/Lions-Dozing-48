<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.5" tiledversion="1.5.0" name="Tiles" tilewidth="32" tileheight="32" tilecount="6" columns="0">
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0">
  <image width="32" height="32" source="brickfloor.png"/>
 </tile>
 <tile id="1">
  <image width="32" height="32" source="brickwall.png"/>
  <objectgroup draworder="index" id="3">
   <object id="10" x="0" y="0" width="32" height="32"/>
  </objectgroup>
 </tile>
 <tile id="3">
  <image width="32" height="32" source="stonewall.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="32" height="32"/>
  </objectgroup>
 </tile>
 <tile id="4">
  <image width="32" height="32" source="grassfloor.png"/>
 </tile>
 <tile id="5">
  <image width="32" height="32" source="woodfloor.png"/>
 </tile>
 <tile id="6">
  <image width="32" height="32" source="woodwall.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="32" height="32"/>
  </objectgroup>
 </tile>
</tileset>
