import xcc.*

def tagsoupParser = new org.ccil.cowan.tagsoup.Parser()

//  without this, it sets the namespace to tag0 for everything
tagsoupParser.setFeature('http://xml.org/sax/features/namespaces',false)

def slurper = new XmlSlurper(tagsoupParser)
File src = new File('../../data/factbook/geos')

XccConn cn=XccConn.fromLabel('')

src.eachFile { file ->
    if (file.isDirectory()) return
    def xml = slurper.parse(file)
    if (! (file.name =~ /.html/)) return
    println file.name
    def uri= '/raw/'+file.name.replaceFirst(/\.html/,'.xml')
    cn.upload( groovy.xml.XmlUtil.serialize(xml), uri )
}