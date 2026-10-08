# Entity Clone Simple Sitemap — manual setup guide

**Entity Clone Simple Sitemap** (`entity_clone_simple_sitemap`) is a small glue
module that extends [Entity Clone](https://www.drupal.org/project/entity_clone) so
that, when you clone an entity, its **Simple Sitemap settings are cloned too**. Out
of the box, Entity Clone duplicates an entity but leaves the copy without the
original's per-entity XML-sitemap overrides; this module copies those overrides
across, keeping sitemap inclusion and exclusion consistent on the clone.

It depends on both **Entity Clone** and **Simple Sitemap** (v4.2.2 or later). For
content entities, it copies the per-entity Simple Sitemap overrides; for config
entities, it preserves the global Simple Sitemap settings. It has no access-control
role of its own — it follows Entity Clone's permissions.

Best of all, there is nothing to configure. Once the module is installed and
enabled it works automatically and transparently: cloned entities behave exactly
like their originals in the sitemap, with no content types, text formats, or other
configuration changes required. It requires **Drupal 10 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Entity Clone and Simple Sitemap.

There is **no configuration page** — the module works automatically once enabled.

## Where it lives

Entity Clone Simple Sitemap adds no admin page and no settings. It hooks into the
existing Entity Clone workflow, so you keep cloning entities exactly as you do now.

## How to use it

1. Make sure both **Entity Clone** and **Simple Sitemap** are installed and
   configured (see [Installation](installation/index.md)).
2. Clone an entity as usual through Entity Clone.
3. The clone automatically inherits the original's Simple Sitemap inclusion/
   exclusion overrides — no manual step needed.

If you want to double-check what was copied during testing, the module can emit debug
logging of the copied overrides.
