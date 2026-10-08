# Feeds Extensible Parsers — manual setup guide

**Feeds Extensible Parsers** (`feeds_ex`) adds a family of parser plugins to the
**Feeds** module so you can import structured **XML**, **HTML** and **JSON** feeds by
writing extraction expressions. Core Feeds handles RSS/Atom and CSV out of the box;
feeds_ex fills the gap for everything else — a custom XML API, a scraped HTML listing,
or a JSON REST endpoint — without writing any PHP.

It plugs directly into the Feeds pipeline (fetch → parse → process) by adding new
**parser** options you select on a Feeds *feed type*. You configure a parser by giving
it a **context** expression that selects the repeating item (the thing that becomes one
imported entity), then a **value** expression per mapping source that pulls each field
out of a matched item. The XPath parsers query XML/HTML with XPath; the JSON parsers
query with **JSONPath** or **JMESPath**; the QueryPath parsers use CSS/QueryPath
selectors. "Lines" variants read JSON‑Lines (one JSON object per line).

Some parsers rely on an external PHP library — JSONPath, JMESPath and QueryPath each
need their own package, all pulled in automatically when you install feeds_ex with
Composer; the XML/HTML XPath parsers rely only on PHP's built‑in libxml/SimpleXML/DOM
extensions. It depends on the **Feeds** module and is **beta** software.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it pulls
   in the expression libraries) and enable it.

## Where it lives in the admin menu

feeds_ex has **no settings page of its own**. Everything is configured inside a Feeds
**feed type** at **Structure → Feed types** (`/admin/structure/feeds`), where its
parsers become choices in the feed type's *Parser* section.

## How to use it

1. Create or edit a **feed type** at **Structure → Feed types**.
2. In the feed type's **Parser** settings, choose one of the parsers feeds_ex adds:
   - **XPath XML** / **XPath HTML** — query XML or HTML documents with XPath.
   - **JsonPath** / **JsonPath Lines** — query JSON with JSONPath (Lines reads
     JSON‑Lines).
   - **JMESPath** / **JMESPath Lines** — query JSON with JMESPath.
   - **QueryPath XML** / **QueryPath HTML** — use CSS/QueryPath selectors.
3. Set the parser's **context** expression — the expression that selects the repeating
   item/row. Each match becomes one imported entity.
4. Under **Mapping**, add a **value** expression for each source you want to extract
   (an XPath/JSONPath/JMESPath/QueryPath expression evaluated against a matched item),
   and map it to a target field on your content type.
5. Adjust the shared parser options as needed: source **encoding**, whether to
   **display errors** while you're debugging an expression, and (for XML/HTML) whether
   to run **libtidy** on messy markup before parsing. The "Lines" parsers add a
   **line limit**.
6. Combine the parser with any Feeds **fetcher** (HTTP, upload, directory) and
   **processor**, then run the import — on demand or on Feeds' cron schedule.

All of these expressions and options are stored as part of the feed type's
configuration, so they export and deploy with the rest of your config.
