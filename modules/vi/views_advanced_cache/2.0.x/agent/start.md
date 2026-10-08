<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Advanced Cache (views_advanced_cache) — agent index

A single Views **cache plugin**, `advanced_views_cache` (title *Advanced Caching*), that exposes a
view display's **cache tags**, **cache contexts**, and **results/output max-age** as
configuration. Depends only on core `views`. Version **2.0.2**, core `^10.3 || ^11`. No
permissions, no services, no routes, no hooks — the entire module is one class:
`src/Plugin/views/cache/AdvancedViewsCache.php` (extends `CachePluginBase`), plus a config schema.

## Where it lives in the UI
Views UI → a display's **Advanced → Other → Caching** → choose **Advanced Caching**. The options
form has three fieldsets: **Cache Tags**, **Cache Contexts**, **Max-Age and Results Cache**.

## Configuration option keys (stored under `cache_options`)
- `cache_tags` — tags to **add** (newline-separated in the form; array in config). Supports token
  replacement: `[current-user:uid]` and Views argument tokens `{{ arguments.NAME }}` /
  `{{ raw_arguments.NAME }}`.
- `cache_tags_exclude` — tags removed by **exact** string match.
- `cache_tags_exclude_regex` — tags removed if a listed regex matches (each is `preg_match`-validated).
- `cache_tags_for_row` (bool) — also apply the add/exclude tag changes to each result row.
- `cache_contexts` — contexts to **add**.
- `cache_contexts_exclude` — contexts to **remove** (`array_diff` against the view's contexts).
- `results_lifespan` / `results_lifespan_custom` — query-results cache lifetime (seconds; `-1` =
  always cache / permanent, `0` = never cache, or a preset/custom value).
- `output_lifespan` / `output_lifespan_custom` — rendered-HTML cache lifetime; **also drives the
  view's `max-age`** (`getDefaultCacheMaxAge()` returns the output lifespan).

## How the options are applied (method → effect)
- `getCacheTags()` — starts from configured `cache_tags` (or the view's default tags if none),
  merges tags from any display plugin implementing `CacheableDependencyInterface`, runs token
  replacement, merges parent tags, then applies `excludeCacheTags()`.
- `getRowCacheTags($row)` — same add/exclude logic per row, but only when `cache_tags_for_row`.
- `alterCacheMetadata(CacheableMetadata)` — adds `cache_contexts`, then **removes**
  `cache_contexts_exclude` via `array_diff`. This is the dangerous knob (see risk below).
- `cacheExpire($type)` / `cacheSetMaxAge($type)` — translate the lifespans into the results/output
  cache cutoff and the view max-age; `-1` maps to `Cache::PERMANENT`.
- Validation: output lifespan must not exceed results lifespan; custom values must be numeric;
  exclude regexes must compile.

## Using context removal safely
`cache_contexts_exclude` drops whichever contexts you list, with no restriction on which ones. Only
remove contexts the view's results do **not** depend on. In particular, a view whose rows differ by
who is viewing — filtered by ownership, group/organic-group membership, or role, or subject to node
access — depends on the corresponding `user`* / `user.node_grants:view` contexts; those must stay so
each viewer gets the correct rows. The module's own README cautions that misconfiguring the excluded
contexts "can lead to … bypassing of standard content access restrictions," so treat context removal
as an advanced option and verify results across accounts before relying on it.

**Tags are the forgiving half:** a missing/over-excluded tag only means stale content. **Contexts
are not:** removing one can leak. Working rule: **be generous with tags, exact about contexts**, and
test any access-varying view with two accounts that should see different results, in both orders.

## Details
- `agent/views/caching.md` — full plugin walk-through, the node_list override recipe, regex
  exclusion, and the context-scoping recipe for access-varying views.
