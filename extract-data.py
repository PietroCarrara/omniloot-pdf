from os import listdir, makedirs
from xml.etree import ElementTree
from bs4 import BeautifulSoup

files = sorted(listdir("./raw-tables"))
tables = {}
xmls = {}

for input in files:
    with open(f"./raw-tables/{input}", "rt") as file:
        html = BeautifulSoup(file.read(), features="html.parser")

    title = html.find("h1").text
    items = map(lambda x: x.text.strip(), html.select("td:nth-child(2)"))
    tables[input] = {
        "title": title,
        "items": list(items),
    }

for input in files:
    table = tables[input]

    xml = ElementTree.Element("itemtable", {"title": table["title"]})
    for item in table["items"]:
        node = ElementTree.SubElement(xml, "item")
        node.text = item

    xmls[input.replace(".html", ".xml")] = xml

makedirs("xml-tables", exist_ok=True)
for output, xml in xmls.items():
    with open(f"./xml-tables/{output}", "wt+") as file:
        ElementTree.indent(xml)
        file.write(ElementTree.tostring(xml, encoding="unicode"))
