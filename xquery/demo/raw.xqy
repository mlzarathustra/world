
let $abbrev := xdmp:get-request-field('abbrev','none')
let $name := /index/country[@abbrev=$abbrev]/name

let $title := concat('Country: ',$name)

let $x := xdmp:set-response-content-type('html')
return 
<html><head><title>{$title}</title></head>
<body>
<h2>{$title}</h2>


</body>
</html>
