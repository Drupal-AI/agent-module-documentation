# Search API common fields — manual setup guide

**Search API common fields** (`search_api_common_field`) lets you add a single
Search API index field whose value is drawn from identically-named properties that
live on **different datasources**. If your index combines two or more datasources
(say, nodes and comments, or nodes and media) and each of them exposes a property
with the same name — `title`, `created`, `status`, `author` — a common field pulls
whichever one applies to each item into one shared field.

Think of it as Search API's built-in *Aggregated fields*, but working **across
datasources** instead of within one. The payoff is a single field you can index,
filter, sort, facet and display, no matter which datasource a given result came
from. That means one facet instead of one-per-datasource, one sort column for a
mixed result set, and a much shorter field list on your index.

The module is deliberately tiny: it adds one Search API processor (`common_field`)
and nothing else. There is no settings page, no permission, no Drush command, and
no config of its own — everything you set up is stored inside the Search API index
configuration entity. It requires the **Search API** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. A common field is added like any other field,
on a Search API index's **Fields** tab under **Configuration → Search and metadata
→ Search API** (`/admin/config/search/search-api`).

## How to use it

You need an index with **two or more datasources** that share at least one property
with the **same name** (for example two entity datasources that both expose
`title` or `created`). Then:

1. Open your index's **Fields** tab and click **Add fields**.
2. In the datasource-independent ("General") group, choose **Common field**.
3. On the field's configuration form, pick the **Common field** — the shared
   property to pull from. The list only offers properties that exist on more than
   one datasource, and each option shows which datasources use it (for example
   *title (used in Content, Comment)*).
4. Save. Adding the field switches on the hidden `common_field` processor
   automatically — you never touch the Processors tab.
5. **Reindex** the index (or *Index now*) so existing items pick up the merged
   value.

From then on, items from any of those datasources populate the same field, so you
can build one facet, one sort, or one Views column that just works across the
whole index. To stop using it, remove the common field; the processor turns itself
off once no common field references it.
