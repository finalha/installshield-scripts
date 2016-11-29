Dim fromFilePath, xPath, attributeName, value, toFilePath

Dim args, doc, node


Set args = wscript.arguments

fromFilePath = args(0)
xPath = args(1)
attributeName = args(2)
value = args(3)
toFilePath = args(4)


Set doc = CreateObject("MSXML.DOMDocument")
doc.Load fromFilePath

Set node = doc.selectSingleNode(xPath)
node.setAttribute attributeName, value

doc.save toFilePath