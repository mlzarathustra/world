import xcc.*

def content = new URL('http://localhost:8050/api/table.xqy').text
def uri='/table/pop.xml'

XccConn cn = XccConn.fromLabel('')
cn.upload( content, uri )


