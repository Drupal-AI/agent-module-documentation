# HTTP Cache Control — manual setup guide

**HTTP Cache Control** (`http_cache_control`) gives you fine-grained control over
the `Cache-Control` and related response headers Drupal sends, so that shared
caches, CDNs, and reverse proxies can hold your pages far longer than browsers
do. Drupal core only offers a single "page cache maximum age"; this module adds
directives such as `s-maxage`, `stale-while-revalidate`, `stale-if-error`,
`must-revalidate`, `no-cache`, `no-store`, `Surrogate-Control`, and targeted
per-vendor `CDN-Cache-Control` headers on top of it.

The typical goal is to keep a long lifetime at the edge (Varnish, Nginx, a CDN)
while browsers cache for only a short time — so visitors always get fresh-enough
pages but your origin server does far less work. The module also lets you set
separate cache lifetimes for 404, 301, and 302 responses, serve stale content
while a fresh copy is fetched in the background, and vary cached responses on
request headers. It pairs especially well with the **Purge** module, where the
proxy holds a long lifetime and Purge invalidates it whenever content changes.

Rather than adding its own admin page, the module **extends Drupal's core
Performance settings form** with extra fields, and stores everything in a single
exportable config object (`http_cache_control.settings`). Behind the scenes an
event subscriber reads that config and layers the directives onto cacheable
responses. The module has no dependencies, permissions, or Drush commands of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact config
keys and Drush recipes — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the cache-control fields added to the
   core Performance form, section by section.

## Where it lives in the admin menu

The module does not add a menu item. Its settings appear as extra fields on the
core **Performance** page at **Configuration → Development → Performance**
(`/admin/config/development/performance`).

## How to use it

1. Enable the module.
2. Go to **Configuration → Development → Performance** and set your shared/proxy
   cache lifetimes, revalidation directives, and any targeted CDN headers (see
   [Configuration](configuration/index.md)).
3. Save. The directives take effect on the next response — run `drush cr` if you
   don't see them immediately.
