# CSS/JS Optimized Assets Proxy — manual setup guide

**CSS/JS Optimized Assets Proxy** (`optimized_assets_proxy`) solves a specific,
frustrating problem: aggregated CSS and JavaScript files that go missing from disk
while cached HTML (and your CDN) still points at them. Drupal only generates its
optimized (aggregated, minified) asset files on the first page render after a cache
rebuild. If that file later disappears from disk — after a `drush cr` that wiped the
`files/` directory, after a fresh deploy into a new release directory, or on a
load‑balanced setup where each server has its own filesystem — Drupal will **not**
regenerate it without another full cache rebuild, and visitors get broken styling or
JavaScript.

This module fixes that transparently. Every aggregate Drupal writes to disk is
**also stored in a database table**. Then a high‑priority request subscriber watches
for incoming requests to aggregate files; the moment one is requested but missing
from disk, it reads the stored copy from the database, **writes it back to disk**
(regenerating the `.gz` gzip companion if core gzip compression is on), and redirects
the browser to the now‑present file. The restore is lazy — it only happens for files
that are actually requested — and it uses a single indexed database lookup, so it
stays fast. Housekeeping is automatic too: cron prunes stale rows, and a cache flush
clears the table so it stays in sync with a rebuild.

It is designed as a companion to the core effort to make optimized‑asset paths
configurable in multi‑webhead architectures, and it lets you avoid needing a shared
NFS mount just to hold public aggregates. Worth knowing: the restore key comes from
the request path and is looked up in the module's own database table — the module
**does not fetch anything from remote URLs**, so it is not a server‑side request
(SSRF) surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form,
routes, permissions or Drush commands. Its behaviour is driven entirely by core's
own aggregation and gzip settings under **Configuration → Development →
Performance** (`system.performance`).

## How to use it

There is nothing to configure in the module itself. Just make sure core CSS/JS
aggregation is enabled the way you want it:

1. Go to **Configuration → Development → Performance**
   (`/admin/config/development/performance`).
2. Enable **Aggregate CSS files** and **Aggregate JavaScript files** so Drupal
   produces the optimized assets this module protects.
3. Enable **Compress files** (gzip) if you use it — the module will regenerate the
   `.gz` variant automatically when restoring a file.

From then on, aggregates are stored to the database as they are generated and
restored on demand whenever they go missing. The module also honours core's
`stale_file_threshold` setting when pruning old rows on cron, and works alongside
AdVAgg‑style optimization through its bundled optimizer classes.
