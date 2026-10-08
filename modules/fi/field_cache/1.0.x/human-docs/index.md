# Field Cache — manual setup guide

**Field Cache** (`field_cache`) lets you set **cache metadata** — max‑age, cache
contexts, and cache tags — directly on a field formatter's settings, and applies
that metadata to the field's rendered output. Field contents often vary by
condition (the current user, the time, some other data), and getting that variation
right normally means writing a preprocess hook. Field Cache moves the control into
the *Manage display* UI so a site builder can tune field‑level caching without
custom code.

It is a performance / developer feature: it sets render cache metadata and has no
content or access role.

> **Important caveat.** Cache metadata is powerful and easy to get wrong. Incorrect
> **contexts** or **tags** can cause **stale** output (content that doesn't update
> when it should) or **over‑varied** output (caching that never gets a hit) — so set
> these deliberately, and test. Also note the module's own warning: **Drupal's
> internal Page Cache / Dynamic Page Cache modules may not honour formatter‑level
> rules for anonymous users.** To rely on this module for anonymous traffic, the
> maintainer suggests uninstalling those internal cache modules and using an
> external cache engine (Varnish, Cloudflare, etc.).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — cache metadata is set per field formatter,
as described in "How to use it" below.

## How to use it

1. Go to **Structure → (content type or bundle) → Manage display**.
2. Open the **formatter settings** (the gear icon) for the field you want to tune.
3. Set the field's **max‑age**, **cache contexts**, and **cache tags** using the
   controls Field Cache adds.
4. **Save** the display, then clear the cache (`drush cr`) so the new metadata takes
   effect.

Set contexts and tags to match exactly what the field's output varies by — no more,
no less — to avoid stale or over‑varied rendering.
