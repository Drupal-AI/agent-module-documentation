# Configure Cache Exclude

## Admin form
- Route: `cacheexclude.settings`
- Path: `/admin/config/system/cacheexclude` (Configuration → System → "Cache exclusions")
- Form class: `Drupal\cacheexclude\Form\AdminSettingsForm` (extends `ConfigFormBase`)
- Gated by core permission `administer site configuration`.
- Saving the form calls `drupal_flush_all_caches()` (a full cache flush) so new rules take effect immediately.

## Config object: `cacheexclude.settings`
Default (`config/install`): `cacheexclude_list: ''`, `cacheexclude_node_types: {}`.
Schema is `FullyValidatable`.

| Key | Type | Meaning |
|---|---|---|
| `cacheexclude_list` | string (multi-line textarea) | Drupal paths to exclude, one per line. |
| `cacheexclude_node_types` | sequence of strings | Node bundle machine names to exclude (each validated by `EntityBundleExists: node`). |

### Path list syntax (`cacheexclude_list`)
- One path per line, entered as internal **Drupal paths** (e.g. `blog`, `contact`).
- `*` is a wildcard, e.g. `blog/*` excludes every page under `blog/`.
- `<front>` matches the site front page.
- Both the current internal path **and** its URL alias are tested (via `path.matcher` + `path_alias.manager`), so an aliased page matches under either form.
- The list is also compared against the site's configured 404 page (`system.site` → `page.404`).

## Set it with Drush (instead of the UI)
```bash
# Exclude the front page and everything under blog/
drush config:set cacheexclude.settings cacheexclude_list $'<front>\nblog/*' -y
# Exclude the "article" and "event" content types (sequence)
drush config:set cacheexclude.settings cacheexclude_node_types.0 article -y
drush config:set cacheexclude.settings cacheexclude_node_types.1 event  -y
drush cache:rebuild
```

## How exclusion works at runtime
`CacheexcludeSubscriber` (service `cacheexclude_event_subscriber`) subscribes to
`KernelEvents::REQUEST`. On each request it:
1. Matches the current path / alias against `cacheexclude_list`.
2. If no path match, checks the routed `node` parameter's bundle against `cacheexclude_node_types`.
3. On a match it triggers `page_cache_kill_switch` (`KillSwitch::trigger()`), so **that response is not written to the anonymous page cache**. The rest of the site keeps caching normally.

Note: this affects the anonymous **page cache** (kill switch). It does not alter dynamic-page-cache or render-cache metadata.

## Drupal 7 → 11 migration
The module ships migrate plugins to carry legacy settings forward:
- Migration: `cacheexclude_settings` (tags: `Drupal 7`, `Configuration`; optional dependency `d7_node_type`).
- Source plugin id `cacheexclude` (reads D7 variables `cacheexclude_list`, `cacheexclude_node_types`).
- Process plugins `cacheexclude_paths` and `cacheexclude_nodes`; destination is the `cacheexclude.settings` config object.
- Update hook `cacheexclude_update_21001()` normalizes `cacheexclude_node_types` to a flat array of enabled bundle keys.
