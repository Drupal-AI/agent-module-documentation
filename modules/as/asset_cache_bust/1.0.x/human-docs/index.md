# Asset cache bust — manual setup guide

**Asset cache bust** (`asset_cache_bust`) makes sure browsers and CDNs pick up
your **latest aggregated CSS and JavaScript** after a change, instead of serving
an old, cached copy. It does this by re‑adding a **cache‑busting query string** to
the aggregated CSS and JS files Drupal produces, so the URL changes when the
assets change and caches are forced to fetch the new version.

This solves a specific, familiar problem: after a deploy or a style change, some
visitors keep seeing the old look because their browser — or a CDN in front of the
site — is still holding the previous aggregate. The extra query‑string parameter
gives the new aggregate a distinct URL, so stale copies are bypassed and clients
re‑fetch.

Under the hood it overrides Drupal's CSS and JS collection renderers (the services
that emit the aggregated asset tags). It is a pure performance / front‑end tweak:
it changes asset URLs only and has no content or access role. It requires
**Drupal 10.5 or 11** and has no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure. Enable the module on a site where CSS/JS updates
are not reliably reaching clients because of browser or CDN caching, and it starts
appending a cache‑busting query string to the aggregated assets automatically.
The clearest place to confirm it is working is a hard reload after a change —
the aggregated CSS/JS URLs should carry a query string that changes when the
underlying assets do.
