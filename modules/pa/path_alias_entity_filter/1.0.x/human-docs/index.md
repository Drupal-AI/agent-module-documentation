# Path Alias Entity Filter — manual setup guide

**Path Alias Entity Filter** (`path_alias_entity_filter`) adds a small but welcome
convenience to Drupal's URL aliases admin screen: an **Entity type** dropdown on
the filter form at **Configuration → Search and metadata → URL aliases**
(`/admin/config/search/path`). On a site with hundreds of aliases, it lets a site
builder narrow the list to just the aliases that point at a particular kind of
thing — content, taxonomy terms, media, users — instead of scrolling through
everything at once.

Behind the scenes the dropdown simply constrains the query to the paths that
belong to the selected type (for example `/node/*` or `/taxonomy/term/*`). The
options populate automatically from the entity types that core exposes to the
Path field (Content, Taxonomy term, Media) plus any additional types you have
opted into under Pathauto's **Enabled entity types**. It's purely an admin listing
aid — it has no effect on content, routing, or access control.

There is nothing to configure: install it, and the dropdown appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## Where it lives in the admin menu

The filter appears on the existing **URL aliases** admin page at
**Configuration → Search and metadata → URL aliases**
(`/admin/config/search/path`), right next to the alias search field.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to `/admin/config/search/path`.
3. Pick an entity type from the new **Entity type** dropdown and click **Filter**
   to narrow the alias list to that type.
4. If you enable Pathauto for additional entity types, those types appear in the
   dropdown automatically.
