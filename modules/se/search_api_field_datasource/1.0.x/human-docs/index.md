# Search API Field Datasource — manual setup guide

**Search API Field Datasource** (`search_api_field_datasource`) provides a Search
API *datasource* that keys indexed items on a **field** instead of on the entity.
Normally a Search API datasource tracks one item per entity, keyed by the entity
ID. This datasource lets you use the value of a field on the entity as the tracking
key instead — so the key in your search backend can match a key that lives
somewhere else.

Why would you want that? Two situations come up. First, when your indexing backend
can only be queried in limited ways and the indexing key has to match a **remote**
key. Second, when you need **custom keying** so the search record lines up with an
external source — for example an enterprise identifier that other systems use to
refer to the same record. In both cases, keying on a field rather than the entity
ID makes the search index speak the same "language" as the system it has to
integrate with. It's also useful for more granular indexing, where field values
become items in their own right.

This is a developer-oriented building block: a datasource plugin with no content
model or access role of its own. Index access still follows Search API and entity
access as usual. It depends on the **Search API** module (`search_api`), requires
**PHP 8.3**, and supports Drupal 10 and 11. There is no settings page — you select
the datasource when you create an index.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

You use the field-keyed datasource when building an index:

1. Go to **Configuration → Search and metadata → Search API** and create a search
   index as you normally would.
2. For the index's data sources, choose one of the **"Field keyed"** entity
   sources this module provides.
3. Set the **field key value** — the field whose value should be used as the
   tracking key.
4. Add your fields and index. The tracking keys will now use the value of that
   field instead of the entity ID.
