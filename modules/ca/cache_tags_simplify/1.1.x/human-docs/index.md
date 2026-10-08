# Cache tags simplify — manual setup guide

**Cache tags simplify** (`cache_tags_simplify`) shrinks the list of cache tags a
Drupal response advertises — the `X-Cache-Tags` header that Purge and reverse
proxies (Varnish, CDNs) read. On a busy listing page Drupal often emits both a list
tag like `node_list` *and* a `node:N` tag for every single row. Since `node_list`
already invalidates whenever any node changes, all those individual `node:N` tags
are redundant. This module drops them, which can take a header from thousands of
tags down to a handful.

It works through a single response event subscriber that runs on every cacheable
response (deliberately just before Purge). It makes two passes. The **first pass,
simplification, is lossless and always runs**: for each list tag present, it removes
the concrete tags that list tag already covers. This never broadens what gets
invalidated, so it is safe to leave on for every site with zero configuration — just
enable the module.

The **second pass, replacement, is lossy and opt-in**. Only if you set a maximum
tag count and a response *still* exceeds it after simplification, the subscriber
starts adding list tags that weren't otherwise present (picking the ones that remove
the most concrete tags first) and dropping their concrete tags until the count fits.
This broadens invalidation — the response now also invalidates on unrelated
events — so it can lower your cache-hit ratio, which is why it only kicks in when a
real header-size ceiling forces it. As a last resort, if the count is *still* over
the limit, the response is made uncacheable.

The built-in "dictionary" of list-tag-to-concrete-tag mappings covers `block`,
`menu_link_content`, `media`, `node`, `file`, `taxonomy_term`, `user`, `profile`,
and `group`. Developers can add or remove mappings with two hooks
(`hook_cache_tags_simplify_dictionary` and its `_alter` variant) — see the
[`agent/`](../agent/start.md) docs.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin menu item and no settings form. The lossless simplification works
the moment you enable the module — most sites need nothing more.

### The one optional setting

If a reverse proxy is rejecting oversized tag headers, cap the number of tags per
response. There is no UI and no config schema; set it in `settings.php`:

```php
// settings.php — cap every response at N cache tags.
// Size N to your proxy's header limit (e.g. Varnish http_resp_hdr_len,
// Apache LimitRequestFieldSize). See the project's README for guidance.
$config['cache_tags_simplify.settings']['max_cache_tags_count'] = 1638;
```

The default value is `false`, meaning "never do the lossy replacement pass — run
only the lossless simplification." Set a number **only** when a header-size ceiling
actually forces it, since the replacement pass trades finer invalidation for a
smaller header.

### When to reach for it

- Keeping the `X-Cache-Tags` header under a Varnish/Apache/CDN header-size limit.
- Diagnosing 400/502 errors caused by huge cache-tag headers behind a proxy.
- Reducing the number of tags a purge backend has to track and invalidate.
