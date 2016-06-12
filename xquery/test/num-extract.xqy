declare function local:first-number( $s ) {
  (
  for $w in tokenize( normalize-space($s), '\s' )
  let $n := number( replace($w, ',', '') )
  return if (xs:string($n)='NaN') then () else <r><s>{ $w }</s><n>{ $n }</n></r>
   )[1]
};

for $s in ('7,174,611,584 (July 2014 est.)', 
  'approximately 15,700 live on the Sovereign Base Areas of Akrotiri and Dhekelia including 7,700 Cypriots, 3,600 Service and UK-based contract personnel, and 4,400 dependents',
  '') 
return <n>{ local:first-number($s) }</n>


