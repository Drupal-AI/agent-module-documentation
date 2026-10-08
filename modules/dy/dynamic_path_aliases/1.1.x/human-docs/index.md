# Dynamic Path Rewrites — manual setup guide

**Dynamic Path Rewrites** (`dynamic_path_aliases`) changes the URL path an entity
lives at — for example serving nodes at `/article/{node}` and `/blog-post/{node}`
instead of the default `/node/123` — **without creating a path alias for every
single piece of content**. Rather than storing one alias entity per node (which
adds up fast on a site with thousands of items), it rewrites paths on the fly as
requests come in and as links are generated, and caches the results so repeat
requests stay quick.

The problem it solves is scale. Pathauto and manual aliases are perfect when you
want a unique, human-readable URL per item, but they create one alias record each,
and on very large sites that becomes a lot of stored data to manage. Dynamic Path
Rewrites takes a different approach: you define a rule once ("route the node
canonical path through `/article/{node}`") and it applies to every matching entity
automatically. Rules can vary per bundle, and the mechanism works with any entity
type's routes, not just nodes.

One trade-off is worth knowing before you start: **tokens are deliberately not
supported.** Every rewrite is a fixed base path plus the entity's route parameter,
because evaluating tokens on every request would defeat the performance goal. If
you need token-driven, per-item URLs (like `/blog/{year}/{title}`), reach for
[Pathauto](https://www.drupal.org/project/pathauto) instead. Dynamic Path Rewrites
depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and manage path rewrites, field
   by field.

## Where it lives in the admin menu

Once enabled, you manage path rewrites at **Configuration → Search and metadata →
URL aliases → Rewrite** (`/admin/config/search/path/rewrite`). The screen is a
list of your `path_rewrite` config entities with buttons to add, edit, and delete
them. Access is gated by the dedicated **Administer dynamic path rewrites**
permission, so grant it only to trusted administrators.
