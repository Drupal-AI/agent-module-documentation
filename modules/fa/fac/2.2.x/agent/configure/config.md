# Configuring Fast Autocomplete

## General settings — `fac.settings`
Form `\Drupal\fac\Form\FacSettingsForm` at `/admin/config/search/fac/settings`.
Keys (schema `fac.settings`, defaults from `config/install/fac.settings.yml`):
- `key_interval` (int, default `604800`) — seconds between rotations of the role-based hash key.
  Only relevant when a configuration runs non-anonymous. Override in settings.php:
  `$config['fac.settings']['key_interval'] = '2592000';`
- `highlighting_script_use_cdn` (bool, default `TRUE`) — load mark.js from cloudflare CDN
  (`fac.markjs_cdn` library) vs a local `/libraries/mark.js/jquery.mark.min.js` (`fac.markjs`).

## Fast Autocomplete configurations — `fac_config` config entities
List/add/edit/delete/enable/disable at `/admin/config/search/fac` (all gated by
`administer fac settings`). Form `\Drupal\fac\Form\FacConfigForm`. Config prefix
`fac.fac_config.*`. Fields (getter → stored key, form default):

| Setting | Key | Notes |
|---|---|---|
| Label | `label` | required |
| Machine id | `id` | immutable after create |
| Search plugin | `searchPluginId` | `BasicTitleSearch` or `SearchApiSearch` (or a custom `fac_search` plugin) |
| Plugin config | `searchPluginConfig` | JSON string; per-plugin sub-form (see below) |
| Input selectors | `inputSelectors` | required; comma-separated jQuery selectors, e.g. `input.form-search` |
| Number of results | `numberOfResults` | default 5 |
| Empty result | `emptyResult` | **raw HTML** shown on focus with empty input; admin-trusted markup |
| View mode per entity type | `viewModes` | sequence keyed by entity type id; view mode used to render each suggestion |
| Min / max key length | `keyMinLength` / `keyMaxLength` | defaults 1 / 10; queries only fire within range |
| All-results link | `allResultsLink` / `allResultsLinkThreshold` | show a "view all" link past N suggestions (0 = always) |
| Breakpoint | `breakpoint` | min viewport px to enable (0 = always) |
| Result location | `resultLocation` | jQuery selector to append results to (empty = the input's form) |
| Highlighting | `highlightingEnabled` | highlight typed keys via mark.js |
| Anonymous search | `anonymousSearch` | **default TRUE**; run the query as user 0 so public JSON cache can't leak restricted content |
| Clean up files | `cleanUpFiles` / `filesExpiryTime` | cron deletes JSON older than a relative string, e.g. `-1 day` |

### BasicTitleSearch plugin config (`searchPluginConfig`)
- `bundle_filter` (multi node type) — restrict to selected content types (empty = all).
- `language_filter` (bool) + `langcode_includes` (checkboxes for `und`/`zxx`) — filter node langcode.
Query: `LIKE %key%` on `node_field_data.title`, `status = 1`, tagged `node_access`, ordered by title.

### SearchApiSearch plugin config
- `index` (required) — a Search API index; `text_fields` (full-text fields, empty = all),
  `sort_field` (+ `search_api_relevance`/`search_api_id`), `sort_direction`, plus the same language filter.
Query is tagged `fac` and `fac_<config_id>`.

## Where instances live at runtime
`hook_page_attachments` (in `fac.module`) loads every enabled `fac_config`, computes the current
user's hash, and emits `drupalSettings.fac[<id>]` (with `jsonFilesPath`, selectors, lengths,
breakpoint, empty result, etc.) plus the `fac/fac` + `fac/fac_plugin` libraries. The page gets the
`fac_key` cache tag so paths refresh when the key rotates. JSON files land in
`public://fac-json/<config>/<lang>/<hash>/<key>.json`.

## Drush / CLI
`drush fac:cache-clear [--fac_config_ids=default,test]` — see [../drush/drush.md](../drush/drush.md).
