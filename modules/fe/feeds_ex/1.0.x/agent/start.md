# feeds_ex — agent start

Adds extensible **Feeds Parser** plugins for formats core Feeds can't parse: XPath (XML/HTML),
JSONPath, JMESPath, and QueryPath. You pick one of these parsers on a Feeds **feed type**, set a
**context** expression (the repeating item) and a **value** expression per mapping source. Depends
on the **feeds** module; it defines no new plugin *type* — it plugs into Feeds' `parser` and
`custom_source` types. Some parsers need an external library. Beta. No admin config route of its own
(configured inside the Feeds feed-type form).

- Choose a parser & write context + per-source expressions on a feed type → [configure/parsers.md](configure/parsers.md)
- The parser plugins it adds (ids, formats, required libraries) → [plugins/parsers.md](plugins/parsers.md)
