# Recurring Dates Field Search API — manual setup guide

**Recurring Dates Field Search API** (`date_recur_search_api`) makes entities with
recurring‑date fields (from the **Recurring Dates Field** / `date_recur` module)
searchable in **Search API** — with one indexed item per **occurrence**. That's
the key idea: a single event that repeats every Tuesday should appear in search
results as each individual Tuesday, so people can find, filter, and sort by the
specific occurrence date rather than just the rule.

To do that, the module defines an extra **content‑entity datasource** for each
recurring‑date field. You use this datasource on your Search API index *instead of*
the standard content datasource that ships with Search API. It generates multiple
index items per entity — one for each occurrence of the recurring date, up to a
configurable point in the future. When a search item is loaded, the occurrence
date is placed on a **computed field** on the entity; you use that computed field
(not the raw recurring‑date field) for filtering, sorting, and display.

It's a site‑search / indexing feature — the indexed dates come from content and
respect the index and entity access; it adds no access‑control role of its own. It
depends on **Recurring Dates Field**, **Search API**, and the **Computed Field**
module. This is a **beta** release (1.0.0‑beta2).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its dependencies.

There is **no standalone settings page** — you configure everything on your Search
API index, as described below.

## How to use it (post‑installation)

1. Edit or create a **Search API index** under **Configuration → Search and
   metadata → Search API**.
2. Enable the **Date occurrences** datasource for the entity type and recurring‑date
   field you want to index (use this instead of the standard content datasource for
   that content).
3. Add the **computed date occurrence field** to the index so you can sort and
   filter items by their occurrence date.
4. Configure the **view mode** used for search results to show the computed date
   occurrence field, then reindex.

> **Tip:** The *Search API Common Fields* module is recommended if you need to
> share common fields between the recurring‑date datasources and Search API's
> built‑in Content datasources.
