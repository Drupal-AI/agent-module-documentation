# KeyCDN — manual setup guide

**KeyCDN** (`keycdn`) keeps the [KeyCDN](https://www.keycdn.com/) content delivery
network in sync with your Drupal site by **purging its edge cache when your content
changes**. It does this in two parts. First, it sets the `Cache-Tag` HTTP header
that KeyCDN needs for tag‑based purging — this happens automatically and needs no
configuration. Second, it provides a **purger plugin for the
[Purge](https://www.drupal.org/project/purge) module** that invalidates cached
content at KeyCDN by tag, so when a node or other entity is updated, the stale copy
on the CDN is cleared.

In practice that means a visitor never sees an out‑of‑date page served from the CDN
after an editor makes a change — the edit triggers a tag‑based purge and KeyCDN
fetches a fresh copy. To configure the purger you need a **KeyCDN API key** and your
**zone/region name**, both available from your KeyCDN account.

Because the API key is a credential, store it securely (backed by an environment
variable) and never commit it. The module depends on the **Purge** module and
supports Drupal 8 through 11. (Note: the project is currently seeking a new
maintainer and is in maintenance‑fixes‑only mode.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   the Purge module.
2. [Configuration](configuration/index.md) — add the KeyCDN purger to Purge and
   enter your API key and region.

## Where it lives in the admin menu

There's no standalone KeyCDN settings page. You add and configure its purger from
the Purge module's configuration at **Configuration → Development → Performance →
Purge** (`/admin/config/development/performance/purge`). The `Cache-Tag` header it
sets requires no configuration at all.
