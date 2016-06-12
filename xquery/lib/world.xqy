
module namespace world='http://miles-beyond.net';

declare function get-population($doc) {
  for $cat in $doc//div[@class='category']
  let $t := lower-case(normalize-space(data($cat/a)))
  where $t = 'population:'
  return data( ($cat/../../following-sibling::tr)[1]//div[@class='category_data'] )

};

declare function get-area($doc) {
  for $cat in $doc//div[@class='category']
  let $t := lower-case(normalize-space(data($cat/a)))
  where $t = 'area:'
  return data(($cat/../../following-sibling::tr[1]//*[@class='category_data'])[1])
};

declare function first-number( $s ) {
  let $words := tokenize( normalize-space($s), '\s' )
  let $r := (
    for $w in $words
    let $n := number( replace($w, ',', '') )
    return if (xs:string($n)='NaN') then () else <r><s>{ $w }</s><n>{ $n }</n></r>
  )[1]
  let $ml := $words = 'million'
  return if ($ml) then 
     <r><s>{concat($r/s,' million')}</s>
        <n>{ $r/n * 1e6 }</n></r>
     else $r



};
