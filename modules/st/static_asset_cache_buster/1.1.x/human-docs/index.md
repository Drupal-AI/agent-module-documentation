# Static Asset Cache Buster — manual setup guide

**Static Asset Cache Buster** (`static_asset_cache_buster`) appends a
cache-busting query string to rendered image and file URLs, so that when you
replace a file at the same path the new version actually reaches visitors instead
of being served from a browser or CDN cache indefinitely. It targets the classic
support ticket: "I uploaded the new logo but it still shows the old one."

The root cause is that Drupal reuses a file's URI when the file is replaced in
place, and image derivatives keep their generated path. A browser or CDN that
cached the old bytes with a long TTL will keep serving them. This module attaches a
version marker to the rendered URL, derived from the file's own metadata, so the
marker changes exactly when the file changes — forcing caches to fetch fresh bytes
while leaving the underlying path stable for external links.

The module works the moment you enable it — **enabling it is the configuration.**
There are no routes, permissions, settings forms, or dependencies beyond core, and
the release targets Drupal 10 and 11. Note that it only changes URLs that Drupal
*renders*; hard-coded URLs in body text or in a theme's CSS are untouched.

> **Trade-off worth weighing on the CDN side.** Changing the query string creates a
> *new* cache key, so old versions stay resident in the CDN until they expire, and a
> site that replaces many files frequently will see its cache-hit ratio dip while
> the new URLs warm up. That is the intended trade — correctness over hit rate. Also
> be aware that some CDN configurations ignore or strip query strings for caching;
> if yours does, check the edge configuration, because otherwise the busting
> silently has no effect.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to click. Once enabled, the module automatically adds the version
marker to rendered image and file URLs across the site. Replace a file in place as
you normally would; because the marker is derived from the file's metadata, the
rendered URL's query string updates on its own and visitors get the new bytes.
