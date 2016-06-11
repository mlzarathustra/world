
let $x := xdmp:set-response-content-type('html')
let $title := 'DEMO - world factbook index'

return 
<html><head><title>{$title}</title></head>
<body>
<h2>{$title}</h2>
{
for $c in /index/country
return <div><a href='raw.xqy?abbrev={$c/@abbrev}'>{$c/name}</a></div>



}
</body>
</html>
