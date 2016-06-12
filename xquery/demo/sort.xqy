
(: ascending/descending just toggles each time,
   which isn't ideal but it works 
 :)
declare function local:th( $label, $desc ) {
  <th><a href='?sort={$label}{ 
     if ($desc) then () else '&amp;desc=true' 
  }'>{$label}</a></th>
};

let $x := xdmp:set-response-content-type('html')
let $title := 'population, area, and density'

let $sort := xdmp:get-request-field('sort')
let $desc := xdmp:get-request-field('desc')

let $rows := 
  for $r in /table/row
  order by 
    if ($sort='name') then $r/name
    else if ($sort='area') then number($r/area/n)
    else if ($sort='population') then number($r/pop/n)
    else if ($sort='density') then number($r/density) 
    else ()
  return $r
let $rows := if ($desc) then reverse($rows) else $rows

return 
<html><head><title>{$title}</title>
<style>
  td {{ border: 1px #ddd solid; }} 
  th {{ color: white; background-color: #333; }}
  th a {{ color: white; }}
  th a:hover {{ color: red; }}
</style>
</head>
<body>
<h2>{$title}</h2>
area is km^2; density is pop/area<br/>
<table>
<tr>
  {  for $label in (tokenize('name population area density','\s'))
     return local:th( $label,$desc ) 
  }
</tr>
{
for $row in $rows
return <tr>
     <td>{$row/name}</td>
     <td>{data($row/pop/s)}</td>
     <td>{data($row/area/s)}</td>
     <td>{$row/density}</td>


   </tr>

}
</table>
</body>
</html>
