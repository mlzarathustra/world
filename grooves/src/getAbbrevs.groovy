
//@Grab(group='org.ccil.cowan.tagsoup', module='tagsoup', version='1.2' )

def tagsoupParser = new org.ccil.cowan.tagsoup.Parser()

def slurper = new XmlSlurper(tagsoupParser)
def file = new File('../../data/factbook/geos/aa.html')
def xml = slurper.parse(file)

def cList = xml.breadthFirst().find { node ->
    //println node.name()
    node.'@class' == 'option_table_wrapper'
}

cList.breadthFirst().findAll { node-> node.name() == 'option' }.each {
    def abbrev = it.attributes().value.replaceFirst(/.*(\w\w)\.html/,'$1')
    def title = it.localText().join()
    if (abbrev) println "$abbrev : $title"
}


