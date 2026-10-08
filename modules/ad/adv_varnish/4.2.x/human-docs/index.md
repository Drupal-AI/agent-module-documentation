# Advanced Varnish cache — manual setup guide

**Advanced Varnish cache** (`adv_varnish`) integrates Drupal with
[Varnish](https://varnish-cache.org), a powerful reverse-proxy cache that sits in
front of your site and serves pages from memory, dramatically reducing server load and
improving performance on high-traffic sites. This guide covers the **4.2.x** release.

The module does the Drupal side of that integration: it emits the cache-control and
cache-tag headers Varnish needs, it invalidates cached content by cache tag (using
Varnish **BAN** requests) whenever the underlying content changes, and it supports
**Edge Side Includes (ESI)** so that per-user fragments of a page can stay dynamic
while the rest of the page is cached. That means you can cache pages even for
**authenticated users** — with user-specific blocks delivered separately via ESI on a
per-role or per-user basis.

Key capabilities include automatic cache-tag invalidation, selective purging by tag or
URL, a "deflate" mode that lowers TTLs gradually (over cron) instead of a hard flush,
per-node-type TTL overrides, multi-server support, and a pluggable **user blocks**
system for injecting dynamic per-user content through ESI.

This is a performance/infrastructure module and it needs real configuration plus a
running Varnish server (and a compatible VCL — the module ships a `default.vcl` you can
base yours on) before it does anything. It requires Drupal core
`^10.1 || ^11 || ^12`, defines a `user_blocks` plugin type, and adds two permissions:
one to administer its configuration and one to let trusted roles bypass Varnish for
debugging.

> **Heads up:** Advanced Varnish is incompatible with the **BigPipe** module — the two
> take opposite approaches to delivering a response, so the module raises a requirements
> error if BigPipe is enabled. Disable BigPipe before relying on Varnish.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and point it at your Varnish server.
2. [Configuration](configuration/index.md) — the settings form (servers, TTLs, cache
   control, ESI, URL filtering), the purge and deflate tools, and permissions.

## Where it lives in the admin menu

Advanced Varnish cache's settings form is at **Configuration → Development → Advanced
Varnish** (`/admin/config/development/adv_varnish`). When the built-in purger is
enabled, additional **Clear Varnish cache** (purge by tag/URL) and **Deflate** forms
appear there too. Per-node-type TTL overrides live on each content type's own edit
form (**Structure → Content types → *(type)* → Edit**), and per-block ESI settings live
on each block's own configuration form.
