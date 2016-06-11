
def tagsoupParser = new org.ccil.cowan.tagsoup.Parser()

//  without this, it sets the namespace to tag0 for everything
tagsoupParser.setFeature('http://xml.org/sax/features/namespaces',false)

def slurper = new XmlSlurper(tagsoupParser)
File src = new File('../../data/factbook/geos')
File dst = new File('../../data/geos-xml')
dst.mkdirs()

src.eachFile { file ->
    if (file.isDirectory()) return
    def xml = slurper.parse(file)
    println file.name
    File dstFile=new File(dst,file.name.replaceFirst(/\.html/,'.xml'))
    dstFile.write( groovy.xml.XmlUtil.serialize(xml), 'utf-8'  )
}