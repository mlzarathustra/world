for $r in /table/row
order by number($r/area/n) descending
return <r>{ ($r/name, $r/area) }</r>