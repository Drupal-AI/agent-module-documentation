# Entity Cache Rebuild — manual setup guide

**Entity Cache Rebuild** (`entity_cache_rebuild`) adds a **"Cache rebuild"** tab to
the canonical page of every content entity that has one — nodes, taxonomy terms,
users, media, commerce products, and any custom content entity with a canonical
link. Clicking that tab invalidates just that entity's cache tags, forcing a fresh
render of the page on its next view, without running a full `drush cr`.

It is a debugging and operations convenience for editors and site builders chasing
a single stale page. When you click the tab, the module triggers the page-cache
kill switch, collects the entity's cache tags, invalidates them, shows a status
message, and redirects you back to the entity. It also fires an alter hook
(`hook_entity_cache_rebuild`) so other modules can add extra cache tags to
invalidate or customise the confirmation message.

Access is gated by a single permission — **rebuild cache for all content entity
types**. There is no settings form; you enable the module and grant the permission
to the roles you trust — grant it to trusted roles only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

There is **no configuration page** for this module. The only setup step beyond
enabling it is granting the permission, described in Installation.

## Where it lives in the admin menu

The module adds no central admin page. Instead, it adds a **Cache rebuild** local
task (tab) alongside *View* / *Edit* on each content entity's canonical page — for
example on a node at `/node/{id}/cache-rebuild`.

## How to use it

1. Grant the **rebuild cache for all content entity types** permission to the roles
   that should have it (**People → Permissions**).
2. Visit a content entity's page (a node, term, user, media item, and so on).
3. Click the **Cache rebuild** tab. The module invalidates that entity's cache
   tags, shows a confirmation message, and returns you to the entity — the next
   view of the page will be freshly rendered.

This is handy for clearing stale render output after an external data change, or for
verifying cache-tag coverage while developing, without flushing the entire site
cache.
