
let $x := xdmp:set-response-content-type('html')
let $title := 'world factbook index'

return 
<html><head><title>{$title}</title></head>
<body>
<h2>{$title}</h2>

<a href='demo'>demo</a>
<br/> <br/>
<a href='api'>api</a>


</body>
</html>
