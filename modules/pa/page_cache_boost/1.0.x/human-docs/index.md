# Page Cache Boost — manual setup guide

**Page Cache Boost** (`page_cache_boost`) improves how well your site absorbs
traffic spikes for **anonymous** visitors. It uses a "stale‑while‑revalidate"
strategy: when a cached page has just expired, it still serves that slightly stale
copy immediately (on a best‑effort basis) and rebuilds a fresh copy afterwards,
so nobody has to wait for the regeneration. A lock ensures that only one request
rebuilds a given page at a time, protecting you from a "cache stampede" where many
simultaneous requests all try to regenerate the same popular page at once.

It does this by decorating core's page‑cache middleware transparently, so there is
nothing to wire up in the UI — you enable it and it works. It relies on core's
**Internal Page Cache** module as its storage backend, so that must be enabled
too. Because it only touches the anonymous page cache, it has no effect on logged‑in
users.

The module is intentionally zero‑configuration out of the box. If you do want to
tune it, two values are adjustable through `$settings` in `settings.php` (see
[Installation](installation/index.md)) — the stale‑response TTL and the rebuild
lock timeout.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, ensure core Page
   Cache is enabled, and optionally tune the two `$settings` values.

There is **no admin configuration page** for this module. It works with zero
configuration; the only optional tuning is done in `settings.php`, covered in the
installation guide.
