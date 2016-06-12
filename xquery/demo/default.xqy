
let $x := xdmp:set-response-content-type('html')
let $title := 'world factbook index'

return 
<html><head><title>{$title}</title></head>
<body>
<h2>{$title}</h2>

<a href='list.xqy'>list with links</a>
<br/> <br/>
<a href='table.xqy'>table</a>
<br/> <br/>
<a href='sort.xqy'>sortable table</a>


</body>
</html>
