# Memcache — manual setup guide

**Memcache** (`memcache`) connects Drupal to a **memcached** daemon and uses it as
a high-performance cache (and optional lock) backend. By default Drupal keeps its
many cache bins in the database, which turns into a bottleneck under load — every
page view hammers the same SQL tables. This module moves that cache data into
fast, in-memory storage that can be shared across several web servers, taking a
big load off the database.

Unlike most modules, Memcache has **no admin settings page**. Everything is
configured in your site's `settings.php`: you declare the memcached servers,
optionally group them into clusters, map cache bins to those clusters, set a key
prefix (so several sites can safely share one daemon), and tell Drupal to use the
memcache backend by default. It works with either the `memcache` or the
`memcached` PECL extension, supports multiple servers, Unix socket connections,
configurable key hashing, and cache-tag invalidation.

Because it depends on outside infrastructure, Memcache does **not** work on enable
alone — you need a running memcached daemon and the matching PHP PECL extension
installed on the server *before* it does anything useful (see
[Installation → Requirements](installation/index.md#requirements)). Once those are
in place and you have added the `settings.php` snippet, the cache backend takes
over immediately. The module has no hard Composer or module dependencies.

The bundled **Memcache Admin** submodule (`memcache_admin`) adds a reporting page
so you can watch memcached statistics — hit/miss ratios, memory slabs, and more.
It is optional and separate from the caching itself.

This guide is written for a **human** setting the site up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the server-side prerequisites (a
   memcached daemon and a PECL extension), then installing and enabling the module.
2. [Configuration](configuration/index.md) — the `settings.php` setup, key by key:
   servers, clusters, bins, prefix, and choosing the default backend.

## Where it lives in the admin menu

Memcache itself has no configuration page in the admin menu — it is configured
entirely in `settings.php` (see [Configuration](configuration/index.md)). If you
enable the **Memcache Admin** submodule, it adds a statistics report under
**Reports** (at `/admin/reports/memcache`) where you can inspect the live
memcached daemon.
