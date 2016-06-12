
import module namespace world='http://miles-beyond.net' at '/lib/world.xqy';

<table id='pop'>
{
for $c in /index/country
let $doc := doc(concat('/raw/',$c/@abbrev,'.xml'))
let $pop-text := world:get-population($doc)
let $area-text := world:get-area($doc)
let $pop := world:first-number( $pop-text )
let $area := world:first-number( $area-text )
return <row>
  <name>{data($c/name)}</name>
  <abbrev>{data($c/@abbrev)}</abbrev>
  <pop>{ ($pop/s, $pop/n, <t>{$pop-text}</t>) }</pop>
  <area>{ ($area/s, $area/n, <t>{$area-text}</t>) }</area>
  <density>{ $pop/n div $area/n }</density>
  </row>
}

</table>
