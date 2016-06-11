import xcc.*
//@Grab(group='org.ccil.cowan.tagsoup', module='tagsoup', version='1.2' )
@Grab(group='com.fasterxml.jackson.core', module='jackson-core', version='2.7.0')
@Grab(group='com.fasterxml.jackson.core', module='jackson-databind', version='2.7.0')

def tagsoupParser = new org.ccil.cowan.tagsoup.Parser()

def slurper = new XmlSlurper(tagsoupParser)
def file = new File('../../data/factbook/geos/aa.html')
def xml = slurper.parse(file)

def cList = xml.breadthFirst().find { node ->
    //println node.name()
    node.'@class' == 'option_table_wrapper'
}

def abbrevs = cList.breadthFirst().findAll { node-> node.name() == 'option' }.collect {
    def abbrev = it.attributes().value.replaceFirst(/.*(\w\w)\.html/,'$1')
    def title = it.localText().join().trim()
    if (abbrev) return "  <country abbrev='$abbrev'><name>$title</name></country>\n"
}.findAll{it}.join()

def doc = """
<index>
$abbrevs
</index>
"""

// println doc

XccConn cn = XccConn.fromLabel('')
cn.upload(doc,'/index.xml')

