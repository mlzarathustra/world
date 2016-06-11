
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

