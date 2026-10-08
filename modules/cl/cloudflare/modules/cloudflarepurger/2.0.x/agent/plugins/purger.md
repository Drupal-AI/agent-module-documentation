<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Purge purger, checks & cache-tag header

## The purger plugin

`CloudFlarePurger` — `@PurgePurger(id = "cloudflare", label = "Cloudflare", types = {"tag", "url", "everything"})`.
It is a **Purge purger** (plugin manager `plugin.manager.purge.purgers`), so you add it as a
purger in the Purge configuration (`/admin/config/development/performance/purge`). It can
invalidate:

- **tag** — Drupal cache tags (mapped to Cloudflare surrogate keys / Cache-Tag),
- **url** — specific URLs,
- **everything** — the whole zone.

Verify it is available:

```php
$defs = \Drupal::service('plugin.manager.purge.purgers')->getDefinitions();
// $defs['cloudflare']['types'] === ['tag','url','everything']
```

It requires the base `cloudflare` module for API credentials and the `purge` module to drive it.
Purge processors/queuers decide *when* invalidations run (e.g. pair with `purge_queuer_url` to
purge changed URLs).

## Diagnostic checks (Purge readiness page)

| Check id | Reports |
|---|---|
| `cloudflare_creds` | Whether Cloudflare credentials are present/valid. |
| `cloudflare_api_rate_limit_check` | API rate-limit usage (via `cloudflare.state`). |
| `cloudflare_daily_limit_check` | Daily tag-purge count against limits. |

These surface on `/admin/config/development/performance/purge` and can block purging when not
satisfied.

## Cache-Tag header generator

`CloudFlareCacheTagHeaderGenerator` (service
`cloudflarepurger.cache_tags.surrogate_key_generator`, an `event_subscriber`) turns Drupal's
`X-Drupal-Cache-Tags` into a Cloudflare-friendly **`Cache-Tag`** response header on
`onResponse()`: it **hashes** tags (Cloudflare doesn't accept Drupal's long tags), respects the
byte limit from parameter `cloudflarepurger.cache_tag_header_limit` (**255**), and omits any tag
whose prefix is in `cache_tag_excludelist`. This is what makes tag-based purging work end to end.
