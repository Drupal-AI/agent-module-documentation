Feeds Extensible Parsers (feeds_ex) adds XPath (XML/HTML), JSONPath, JMESPath and QueryPath parser plugins to the Feeds module, so you can import structured XML, HTML and JSON feeds by writing extraction expressions. It is a beta add-on that depends on Feeds.

---

feeds_ex extends the Feeds pipeline (fetch → parse → process) with a family of **Feeds Parser** plugins for formats core Feeds does not parse natively. Each parser is configured on a Feeds **feed type** by supplying a **context** expression that selects the repeating item/row, then per-mapping-source **value** expressions that pull each field out of a matched item. The XPath parsers (`xml`, `html`) query documents with XPath; the JSON parsers query with JSONPath (`jsonpath`, `jsonpathlines`) or JMESPath (`jmespath`, `jmespathlines`); the QueryPath parsers (`querypathxml`, `querypathhtml`) use CSS/QueryPath selectors. "Lines" variants read JSON-Lines (one JSON object per line) with a configurable `line_limit`. Parsers share settings for source **encoding**, whether to **display errors**, and (for XML/HTML) whether to run libtidy (`use_tidy`) before parsing. Some parsers require an external PHP library — JSONPath needs `softcreatr/jsonpath`, JMESPath needs `mtdowling/jmespath.php`, QueryPath needs `gravitypdf/querypath` — all pulled in automatically when the module is installed via Composer; the XML/HTML XPath parsers rely only on PHP's libxml/SimpleXML/DOM extensions. The module also provides matching `custom_source` plugins (`xml`, `querypathxml`, `json`) that let editors add expression-driven sources in the Feeds mapping UI, plus small utility services and a JMESPath runtime factory. It is beta software.

---

- Import an XML feed that is not RSS/Atom by selecting items with an XPath context expression.
- Scrape and import data from an HTML page using XPath queries.
- Import a JSON API response into content entities using JSONPath expressions.
- Import a JSON feed using JMESPath expressions instead of JSONPath.
- Parse a JSON-Lines (newline-delimited JSON) stream one object per row.
- Use CSS/QueryPath selectors to extract fields from XML or HTML documents.
- Set a context expression to define the repeating item that becomes one imported entity.
- Map each Feeds target field to a per-source XPath/JSONPath/JMESPath/QueryPath value expression.
- Pull an XML element's inner HTML or raw markup into a field via the XML custom source options.
- Extract an XML attribute value using the QueryPath XML custom source's attribute setting.
- Limit how many lines are read from a JSON-Lines source with `line_limit`.
- Choose or auto-detect the source character encoding before parsing.
- Turn on error display to debug a malformed expression or feed during setup.
- Run libtidy on messy HTML (`use_tidy`) before XPath/QueryPath extraction.
- Add the JSONPath library with `composer require softcreatr/jsonpath` to enable JSONPath parsers.
- Add the JMESPath library with `composer require mtdowling/jmespath.php` to enable JMESPath parsers.
- Add the QueryPath library with `composer require gravitypdf/querypath` to enable QueryPath parsers.
- Import namespaced XML by writing XPath that accounts for the document namespaces.
- Build a feed type that fetches JSON from a REST endpoint and maps fields to a node type.
- Periodically re-import a scraped HTML listing on Feeds' cron schedule.
- Migrate legacy data delivered as XML/JSON into Drupal entities using expression mapping.
- Combine feeds_ex parsers with any Feeds fetcher (HTTP, upload, directory) and processor.
- Reuse the same expression parser across multiple feed types by selecting it per feed type.
- Deploy parser and source expression settings as Feeds config (they export with configuration).
- Install parsers with the Ludwig module when Composer is not used to manage libraries.
