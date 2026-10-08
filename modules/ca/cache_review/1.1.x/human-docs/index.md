# Cache Review — manual setup guide

**Cache Review** (`cache_review`) is a developer tool for understanding how Drupal's
internal render and page caching is behaving. It lets you inspect the cache
decisions behind a page — hits and misses, the cache tags and contexts involved — so
you can debug why something is or isn't being cached and tune your caching
accordingly.

This is a debugging aid, in the **Development** package, with no role in content or
access control. Because it exposes **internal cache information** about your site, it
is meant for developers: keep it to your dev and staging environments and gate it to
trusted users rather than running it on production.

The module works on Drupal 9, 10, and 11.

This guide is written for a **human** working through the tool. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Cache Review presents a tool for reviewing cache behaviour once enabled. Treat it as
a development-only feature and keep access limited to developers.

## How to use it

Enable the module in a development or staging environment, then use its review tool
to inspect how render and page caching is deciding to cache (or not cache) your
pages — the hits, misses, tags, and contexts at play. Use what you see to debug
cache problems and tune your caching. Disable or remove it before promoting to
production, since it surfaces internal cache details.
