# Configure a feeds_ex parser

feeds_ex has **no admin route of its own** (`configure` is null). Its parsers are configured on a
**Feeds feed type** at **Admin → Structure → Feed types** (`/admin/structure/feeds`): on the feed
type, set the **Parser** plugin to one of feeds_ex's parsers, then configure it and map sources.

## How the parsers work

Each parser reads a document/stream and produces rows using two kinds of expression:

1. **Context** — one expression that selects the repeating item; each match becomes one imported
   item (Feeds computes `total` from it). Set once per feed type.
2. **Value (per source)** — for every mapping source you add, an expression evaluated *relative to*
   the current context item to extract that field's value. Empty value expressions are skipped.

Expression language depends on the chosen parser: XPath for `xml`/`html`, JSONPath for
`jsonpath`/`jsonpathlines`, JMESPath for `jmespath`/`jmespathlines`, CSS/QueryPath for
`querypathxml`/`querypathhtml`.

## Settings (config schema `feeds_ex.schema.yml`)

Stored on the feed type under `parser.settings`. Defaults from `ParserBase::defaultConfiguration()`:

| Key | Default | Meaning |
|---|---|---|
| `context.value` | `''` | Expression selecting the repeating item/row |
| `source_encoding` | `['auto']` | Source character encoding(s); `auto` = detect. An autocomplete endpoint (`/_feeds_ex/encoding_autocomplete`, permission `administer feeds`) suggests values |
| `display_errors` | `false` | Show parse/expression errors (log at DEBUG) instead of hiding them — use while building a feed type |
| `line_limit` | `100` | Rows read per batch; also caps lines for the JSON-Lines parsers |
| `use_tidy` | `false` | *(XML/HTML parsers only, schema type `feeds_ex_xml_parsers`)* run libtidy on input before parsing (only offered when PHP `tidy` is loaded) |

Per-source expressions are stored as Feeds mapping sources (`context` and each source `value`), and
are validated when you save the feed type (`validateExpression()`), so a malformed XPath/JSONPath is
reported on the form.

## Custom sources (mapping UI)

feeds_ex also registers Feeds `custom_source` plugins so editors can add expression-driven sources
inline while mapping:

- `xml` ("XML Xpath") — value expression plus `raw` (return raw markup), `inner` (inner HTML), `type`.
- `querypathxml` ("QueryPath XML") — like `xml` plus an `attribute` option to grab an attribute value.
- `json` ("Json") — a plain JSON expression source.

## Libraries

XPath `xml`/`html` need only PHP libxml/SimpleXML/DOM. The others need an external library — see
[../plugins/parsers.md](../plugins/parsers.md). Installing feeds_ex with Composer pulls them all in.
