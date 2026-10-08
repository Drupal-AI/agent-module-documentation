# Varnish Purger — manual setup guide

**Varnish Purger** (machine name `varnish_purger`) is the piece that lets Drupal
tell your Varnish reverse proxy "this page is stale, drop it." It plugs into the
[Purge](https://www.drupal.org/project/purge) module and, whenever content
changes, sends `BAN`/`PURGE` (and `URIBAN`) HTTP requests to your Varnish
servers so visitors never see out‑of‑date pages served from the cache.

A small but important naming quirk: the Drupal.org project is called
`varnish_purge`, but the **main module's machine name is `varnish_purger`** — so
you enable it with `drush en varnish_purger`. This guide (and its directory) use
the project name to match the project URL, but every command targets
`varnish_purger`.

The module ships three "purger" plugins you choose between: **`varnish`** fires
one HTTP request per invalidation (great for clearing by cache tag),
**`varnishbundled`** packs a whole batch of invalidations into a single request
to cut traffic, and **`varnish_zeroconfig_purger`** is a minimal‑setup option
that reads your Varnish server IPs from Drupal's `reverse_proxy_addresses`
setting and pairs with the bundled `zeroconfig.vcl`. A built‑in diagnostic check
(`varnishconfiguration`) stops half‑configured purgers from loading and warns
about mismatched schemes and ports. The module has **no admin page of its own** —
you add and configure purgers entirely through Purge's UI or Drush.

This guide is written for a **human** clicking and typing through setup. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Purge companions, and pick the submodules you need.
2. [Configuration](configuration/index.md) — add a purger and set every field
   (hostname, port, request method, headers, timeouts), plus the zero‑config
   route via `settings.php`.

## Where it lives in the admin menu

Varnish Purger adds no menu item of its own. Everything happens on Purge's page
at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), where you add a purger, choose
the Varnish plugin, and open its "Configure" form. You can do all of it from
Drush instead (`drush p:purger-add varnish`).

## How to use it

Once a Varnish purger is configured and Purge has a queuer (for example the core
cache‑tags queuer) and a processor (cron or late‑runtime), the flow is
automatic: editing a node, block, or menu queues invalidations, and the purger
sends the matching `BAN`/`PURGE` requests to Varnish. For tag‑based clearing you
enable the **`varnish_purge_tags`** submodule so Drupal emits a `Cache-Tags`
response header that your VCL can ban against. The **`varnish_image_purge`** and
**`varnish_focal_point_purge`** submodules issue `URIBAN` requests to flush
image‑style derivatives when images or focal‑point crops change.
