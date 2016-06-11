package xcc

import com.marklogic.xcc.*
import groovy.transform.Canonical

@Canonical
class XccConn {
    static def xqBundle
    static {
        // doesn't work from the command line.  (?!?)
        //   ResourceBundle.getBundle('xq')

        FileInputStream fis=new FileInputStream('xq.properties')
        xqBundle = new PropertyResourceBundle(fis)
    }

    static String uriStr(String label) {
        def uriStr = xqBundle.getString('uri' + (label?".$label":'')).trim()
        if (!uriStr) {
            println 'uri undefined in properties file.'
            System.exit(-1)
        }
        uriStr
    }

    static XccConn fromLabel(String label) {
        XccConn xc = new XccConn(uriStr(label)); xc.label=label
        return xc
    }

    String uriStr, label=''
    URI uri
    ContentSource cs
    Session session
    RequestOptions reqOptions
    ContentCreateOptions cntOptions
    long elapsed // after calling eachString or firstString, this will be set

    XccConn(String u) {
        uri = new URI(uriStr=u)
        cs=ContentSourceFactory.newContentSource(uri)
        session=cs.newSession()
        reqOptions = new RequestOptions()
        reqOptions.setCacheResult(false)

        cntOptions = new ContentCreateOptions()
        cntOptions.setFormatXml()
    }

    void setCollections(coll) { cntOptions.setCollections(coll) }

    void eachString(String query, Closure action) {
        Request req = session.newAdhocQuery(query, reqOptions)
        def start = new Date().getTime()
        ResultSequence rs = session.submitRequest(req)
        elapsed = new Date().getTime() - start
        while (rs.hasNext()) {
            action.call(rs.next().getItem().asString())
        }
        rs.close()
    }
    String firstString(String query) {
        Request req = session.newAdhocQuery(query, reqOptions)
        def start = new Date().getTime()
        ResultSequence rs = session.submitRequest(req)
        elapsed = new Date().getTime() - start
        def result=''
        if  (rs.hasNext()) {
            result = rs.next().getItem().asString()
        }
        rs.close()
        result
    }

    def upload( content, docUri ) {
        try {
            session.insertContent(
                    ContentFactory.newContent(
                            docUri as String,
                            content as String, cntOptions))
        }
        catch (Exception ex) { ex.printStackTrace() }
    }


    def invoke(String modUri) { invoke(modUri,[:]) }

    //  invoke named module, using reqOptions
    //  returns a List of Strings
    //
    def invoke(String modUri, Map vars) {
        Request req = session.newModuleInvoke(null)
        req.setModuleUri(modUri)
        req.setOptions(reqOptions)
        if (vars) vars.keySet().each { k->
            //println "$k -> ${vars[k]}"
            req.setNewStringVariable(k,vars[k])
        }

        ResultSequence rs = session.submitRequest(req)

        def rval=rs.asStrings()
        rs.close()

        rval
    }



}