# Cache Tags CDN Optimizer — manual setup guide

**Cache Tags CDN Optimizer** (`cache_tags_cdn_optimizer`) makes CDN and reverse-proxy
cache purging less wasteful on sites that use a lot of entity references. Drupal
attaches cache tags to referenced entities fairly broadly, which can mean that
editing one referenced entity triggers a purge of far more cached pages than
actually needed. This module replaces those cache tags for referenced entities so
that a purge only clears content when it genuinely has to.

The practical effect is fewer needless purges and better CDN cache hit rates —
especially on sites where many pages reference the same entities. It changes *when*
cached content is purged, not *who* can see it: there is no access-control role here,
and enabling it is all that's needed — there is no settings form.

The module works on Drupal 10 and 11 (and reports compatibility with 12).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere to configure — Cache Tags CDN Optimizer has no settings form. Its effect is
automatic once the module is enabled.

## How to use it

Enable the module and it takes over the cache tags for referenced entities right
away. You do not tune anything; the benefit — fewer over-broad purges reaching your
CDN or reverse proxy, and higher cache hit rates — applies automatically. It is most
worthwhile on sites with heavy entity referencing sitting behind a CDN.
