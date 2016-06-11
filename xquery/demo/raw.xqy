
declare function local:get-population($doc) {
  for $cat in $doc//div[@class='category']
  let $t := lower-case(normalize-space(data($cat/a)))
  where $t = 'population:'
  return data( ($cat/../../following-sibling::tr)[1]//div[@class='category_data'] )

};

declare function local:get-area($doc) {
  for $cat in $doc//div[@class='category']
  let $t := lower-case(normalize-space(data($cat/a)))
  where $t = 'area:'
  return data(($cat/../../following-sibling::tr[1]//*[@class='category_data'])[1])
};


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
<div>population: { local:get-population($doc) }</div>
<div>area: { local:get-area($doc) }</div>


</body>
</html>
