# Search API exact match boost — manual setup guide

**Search API exact match boost** (`search_api_exactmatch_boost`) is a
[Search API](https://www.drupal.org/project/search_api) processor that pushes
results whose field value **exactly equals** the search term to the top of the
result list. If you use partial (substring) matching, an exact title match would
otherwise be ranked no higher than a page that merely mentions the term — this
module fixes that, so "I know exactly what I'm looking for" searches surface the
right record first.

It adds a single processor, **Exact match boosting**, which runs after the query
executes and reorders results at query time (no re-indexing needed). You enable it
per index and pick which text fields it should consider. On the **Search API DB**
backend with `string` fields, it queries the field's table directly, so it can find
and promote exact matches even when they'd otherwise fall on a later results page.
For other backends or field types, it works with the items already on the current
page (a trimmed, case-insensitive compare).

> **A caveat worth knowing about pagination.** Because the processor adds matches
> to page 1 and (optionally) removes them from later pages, a **paged** display can
> end up showing a different number of items per page. The module's own docs
> recommend it works best on **non-paged** displays, and note it may not play
> nicely with the Views "result summary" plugin. Keep that in mind when choosing
> where to apply it.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and tune the processor on a
   Search API index.

## Where it lives in the admin menu

There is no global settings page. You enable the processor per index on its
**Processors** tab under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`).
