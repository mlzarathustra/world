
import module namespace world='http://miles-beyond.net' at '/lib/world.xqy';


let $abbrev := xdmp:get-request-field('abbrev','none')
let $name := /index/country[@abbrev=$abbrev]/name

let $doc := doc(concat('/raw/',$abbrev,'.xml'))
let $doc-name := $doc//span[@class='region_name1']

let $title := concat('Country: ',$name)

let $x := xdmp:set-response-content-type('html')
return 
<html><head><title>{$title}</title></head>
<body>
<h2>{$title}</h2>
<div>population: { world:get-population($doc) }</div>
<div>area: { world:get-area($doc) }</div>


</body>
</html>
