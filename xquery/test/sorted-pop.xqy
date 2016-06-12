for $r in /table/row
order by number($r/pop/n) descending
return <r>{ ($r/name, $r/pop) }</r>