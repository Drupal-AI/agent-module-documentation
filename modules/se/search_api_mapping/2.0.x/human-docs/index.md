# Search API Value Mapping — manual setup guide

**Search API Value Mapping** (`search_api_mapping`) lets you translate raw field
values into friendlier or normalized values as content is indexed, storing the
result in a new index field. Instead of indexing a status code like `waiting` or a
terse key like `1`, you define a static map that turns it into something more
useful for searching and faceting — `undone`, `Active`, and so on. You can map
many different source values onto the same target value, which is handy for
collapsing several states into one bucket.

The project's own example shows the idea well: a set of order states —
`open`, `waiting`, `successfully closed`, `unsuccessfully closed` — mapped down to
just two target values, `undone` and `done`. The new field that holds the mapped
values is **facet-compatible**, so you can build clean, human-readable facets from
messy underlying data. Whether the mapping keys off the source *key* or the source
*value* depends on the type of the field you're mapping.

The module has no other module dependencies of its own and works on Drupal 9, 10,
and 11. It is a pure indexing feature — the mappings are defined by an
administrator and it has no access-control role. It has been tested with Search
API, Search API Solr, and the Facet API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Value Mapping surfaces as a field type you add to a Search API index. Edit your
index and add a mapping field on the **Fields** tab (**Configuration → Search and
metadata → Search API → your index → Fields**). In the field's configuration you
choose the source field and then enter the value pairs — each source key or value
alongside the target value it should become. Save, then re-index your content so
the mapped values are written to the new field. Because that field is
facet-compatible, you can immediately use it to drive a facet in your search.
