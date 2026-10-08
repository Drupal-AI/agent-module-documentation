# Cloudflare Purger — manual setup guide

**Cloudflare Purger** (`cloudflare_purger`) adds Cloudflare CDN cache
invalidation to Drupal by plugging into the **Purge** module as a purger. It
works by cache *tags*: it adds a hashed `Cache-Tag` HTTP response header to all of
Drupal's cacheable responses so Cloudflare stores those tags alongside the cached
content, and then, when Drupal invalidates one or more cache tags, it calls the
Cloudflare API to purge exactly those tags at the edge. The result is a CDN whose
cache stays in sync with your content without over‑purging.

It's the modern, Purge‑integrated way to keep Cloudflare fresh. (The older
`cloudflare` module's own purge submodule is, by the maintainers' account, no
longer compatible with Cloudflare's 2026 header and account limits and duplicates
this functionality.) You point it at your Cloudflare zone and token on its own
settings page, then enable it as a purger inside the Purge pipeline; your
Cloudflare API token is kept in a **Key** entity — never hard‑coded or committed.

Because it depends on the **Purge** and **Key** modules, it slots into an existing
Purge setup. There are a couple of things worth planning for: pages with many
cache tags produce a large `Cache-Tag` header, and some hosts cap header sizes, so
the module lets you set a maximum length (above which it marks the response
uncacheable at Cloudflare rather than sending a truncated header). And if several
environments share one Cloudflare zone, you can set a per‑environment cache‑tag
prefix to stop them purging each other.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Purge and Key).
2. [Configuration](configuration/index.md) — add the purger in Purge, point it at
   your Cloudflare token Key, and tune the header‑size and prefix settings.

## Where it lives in the admin menu

Cloudflare Purger has its own settings page at **Configuration → Web services →
Cloudflare Purger** (`/admin/config/services/cloudflare-purger`), where you set
the **Zone ID** and pick the **Key** holding your API token. You then add and
enable it as a purger inside the **Purge** module at **Configuration → Development
→ Performance → Purge** (`/admin/config/development/performance/purge`). Its
header‑size and cache‑tag‑prefix options are set in your site's `settings.php` /
`services.yml`.
