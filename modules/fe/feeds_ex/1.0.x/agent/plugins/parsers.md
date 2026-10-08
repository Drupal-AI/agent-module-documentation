# Parser plugins feeds_ex adds

feeds_ex **does not define a plugin type** — it provides `@FeedsParser` plugin *instances* for the
**Feeds** module's `parser` type (`Drupal\feeds\Feeds\Parser`). All extend feeds_ex's abstract
`ParserBase` (in `src/Feeds/Parser/`). Select one as the Parser on a Feeds feed type; configure with
[../configure/parsers.md](../configure/parsers.md).

| Parser id | Title | Format / language | Required library |
|---|---|---|---|
| `xml` | XML | XML via **XPath** | none (PHP libxml/DOM) |
| `html` | HTML | HTML via **XPath** (extends `xml`) | none (PHP libxml/DOM) |
| `jsonpath` | JsonPath | JSON via **JSONPath** | `softcreatr/jsonpath` (`Flow\JSONPath`) |
| `jsonpathlines` | JSON Lines JSONPath | JSON-Lines via JSONPath (extends `jsonpath`) | `softcreatr/jsonpath` |
| `jmespath` | JSON JMESPath | JSON via **JMESPath** | `mtdowling/jmespath.php` (`JmesPath`) |
| `jmespathlines` | JSON Lines JMESPath | JSON-Lines via JMESPath (extends `jmespath`) | `mtdowling/jmespath.php` |
| `querypathxml` | QueryPath XML | XML via **QueryPath** (extends `xml`) | `gravitypdf/querypath` |
| `querypathhtml` | QueryPath HTML | HTML via QueryPath (extends `querypathxml`) | `gravitypdf/querypath` |

The `*lines` parsers read JSON-Lines (one JSON document per line), honoring `line_limit`. Parsers
that need a library throw a `\RuntimeException` ("… library is not installed") if the class is
missing; `composer require drupal/feeds_ex` installs all of them.

## How a parser evaluates

`ParserBase::parse()` calls `loadLibrary()`, then `executeContext()` to select items, then for each
item runs `executeSourceExpression()` for every configured source. Subclasses implement:

- **XPath** (`XmlParser`): builds a `DOMDocument`, wraps it in `XpathDomXpath`, `query()` for the
  context node-set and `evaluate()` for each source expression. `HtmlParser` loads HTML instead of XML.
- **JSONPath** (`JsonPathParser`): decodes JSON, runs `Flow\JSONPath\JSONPath` queries; a lexer
  pre-validates each expression.
- **JMESPath** (`JmesPathParser`): uses a `JmesPath` runtime (built by the
  `feeds_ex.jmes_runtime_factory` service) to search the decoded data.
- **QueryPath** (`QueryPathXmlParser`): runs QueryPath/CSS selectors over the document.

## Supporting pieces

- **Encoders** (`src/Encoder/`): `Text`, `Xml`, `Html` — convert source bytes to the configured
  `source_encoding` before parsing.
- **Services** (`feeds_ex.services.yml`): `feeds_ex.jmes_runtime_factory`, `feeds_ex.json_utility`,
  `feeds_ex.xml_utility`.
- **Custom sources** (`src/Feeds/CustomSource/`): `@FeedsCustomSource` plugins `xml`, `querypathxml`,
  `json` for the Feeds mapping UI (see the configure doc).

To add your own expression parser, subclass `ParserBase` (or one of these) with a new `@FeedsParser`
id — same mechanism these plugins use.
