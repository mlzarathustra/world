let $cats := doc('/raw/fr.xml')//div[@class='category']
for $cat in $cats
let $t := lower-case(normalize-space(data($cat/a)))
where $t = 'population:'
return $cat