# Site Settings Domain — manual setup guide

**Site Settings Domain** (`site_settings_domain`) is a bridge module: it adds **domain
context** to the entities created by the [Site Settings](https://www.drupal.org/project/site_settings)
module, using the [Domain](https://www.drupal.org/project/domain) module. On a
multi-domain site, this lets each domain carry its **own values** for your site settings,
so a shared setting can be overridden per domain rather than being the same everywhere.

You get to decide how missing values behave. You can add a **fallback** — a
setting with no domain context — so that if no more specific per-domain value exists,
there is always something to show. Or you can leave the fallback out, in which case only
a setting specific to the current domain is returned by the domain-aware loaders. One
important practical point: to actually get per-domain behavior you must use the **site
setting loaders and blocks that have domain context enabled**, not the default Site
Settings loaders and blocks. If the Domain Access module is also enabled, the module
additionally checks editor access.

The module depends on both **Site Settings** and **Domain**, and adds a permission
(`delete domain context specific site setting entities`) that gates deleting a
domain-specific setting. It supports Drupal 10.3+ and 11. Note this is an **alpha**
release — the maintainer flags that not everything is thoroughly tested yet and the
project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   and its dependencies.

## How to use it

Once enabled alongside Site Settings and Domain, create your site settings as usual, but
give them a domain context and, if you want a catch-all, add a fallback entry with no
domain. When you place or render settings, choose the **domain-context-aware** loaders
and blocks the module provides so the right per-domain value is returned. Deleting a
domain-specific setting requires the **`delete domain context specific site setting
entities`** permission — grant it only to trusted roles.
