
import module namespace world='http://miles-beyond.net' at '/lib/world.xqy';

let $x := xdmp:set-response-content-type('html')
let $title := 'DEMO - world factbook index'

return 
<html><head><title>{$title}</title>
<style>
  td {{ border: 1px #ddd solid; }} 

</style>
</head>
<body>
<h2>{$title}</h2>

<table>
<tr>
  <th>country</th>
  <th>population</th>
  <th>sq km</th>
  <th>density</th>
  <th>pop - full text</th>
  <th>area - full text</th>
</tr>
{
for $c in /index/country
let $doc := doc(concat('/raw/',$c/@abbrev,'.xml'))
let $pop-text := world:get-population($doc)
let $area-text := world:get-area($doc)
let $pop := world:first-number( $pop-text )
let $area := world:first-number( $area-text )
return <tr>
  <td>{$c/name}</td>
  <td>{ data($pop/s) }</td>
  <td>{ data($area/s) }</td>
  <td>{ $pop/n div $area/n }</td>
  <td>{ $pop-text }</td>
  <td>{ $area-text }</td>
  </tr>
}
</table>

</body>
</html>
