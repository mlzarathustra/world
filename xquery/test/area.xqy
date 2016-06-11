let $cats := doc('/raw/fr.xml')//div[@class='category']
for $cat in $cats
let $t := lower-case(normalize-space(data($cat/a)))
where $t = 'area:'
return ($cat/../../following-sibling::tr)[1]//div[@class='category_data']




(: $cat/../../following-sibling::tr//div[@class='category_data'] :)