# Debug Cacheability Headers Split — manual setup guide

**Debug Cacheability Headers Split** (`debug_cacheability_headers_split`) fixes a
specific, annoying problem that developers hit when debugging Drupal's cache. When
you turn on Drupal's debug cacheability headers, the site emits
`X-Drupal-Cache-Tags` and `X-Drupal-Cache-Contexts` response headers so you can
see exactly which cache tags and contexts a page depends on. On complex sites those
values can grow very large — and most web servers cap the size of a single HTTP
header (8 KB is a common limit). When a header blows past that cap, the result is a
server error: a white screen of death, a 502 Bad Gateway, or similar.

This module watches those debug headers and, whenever one exceeds a configured size
limit, automatically **splits** it into several smaller headers (for example
`X-Drupal-Cache-Tags`, `X-Drupal-Cache-Tags-1`, `X-Drupal-Cache-Tags-2`, and so
on), each safely under the limit. That lets debug cacheability headers keep working
even on pages with a huge number of cache tags. It has no dependencies beyond
Drupal core, lives in the **Development** package, and supports Drupal 10 and 11.

This is a developer/debugging aid. Drupal's debug cacheability headers are
themselves a development feature that you normally leave **off in production**, so
this module is only relevant on environments where those headers are enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the size limit and chunk size, and
   the `settings.php` override alternative.

## Where it lives in the admin menu

The settings form is at **`/admin/config/development/settings/cacheability`**
(config `debug_cacheability_headers_split.settings`). You can also set the values
directly in `settings.php` / `settings.local.php` instead of using the form — see
[Configuration](configuration/index.md).
