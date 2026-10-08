<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Control Override — agent index

Two services, one config object, **no UI** (`configure` is `null`), no permissions, no
plugins, no Drush, no routes. PHP ≥ 8.1, core ≥ 10.2.

| Service ID | Class | Role |
|---|---|---|
| `cache_control_override.cache_control_override_subscriber` | `EventSubscriber\CacheControlOverrideSubscriber` | rewrites `Cache-Control: public, max-age=…` from the response's **bubbled** cacheability metadata |
| `cache_control_override.page_cache_response_policy.deny_on_cache_override` | `PageCache\DenyOnCacheControlOverride` | `page_cache_response_policy` returning `DENY` when bubbled max-age is `0` |

- **The settings (`max_age.minimum` / `max_age.maximum`), defaults, drush recipes, how to
  verify the header** → [configure/settings.md](configure/settings.md)
- **Exact override algorithm, the conditions that skip it, and how to extend/override the
  behaviour** → [api/behavior.md](api/behavior.md)

Default config (`cache_control_override.settings`):

```yaml
max_age:
  minimum: 0     # floor; 0 = no floor
  maximum: -1    # ceiling; -1 (Cache::PERMANENT) = no ceiling
```

Key fact: a **bubbled max-age of `-1` (`Cache::PERMANENT`) is left untouched** — that page
keeps the site-wide `system.performance:cache.page.max_age`. Only finite bubbled values are
written to the header, and only `> 0` values are clamped.
