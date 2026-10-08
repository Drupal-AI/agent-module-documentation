<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: Fallback (ad_entity_fallback) — agent index

Submodule of **ad_entity**. Lets any Advertising entity nominate another Advertising entity as a
**fallback** that is loaded when the original ad slot renders **empty**. Package `Advertising`.
Depends on `ad_entity:ad_entity`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir
`8.x-1.x` (project release 8.x-1.6). No permissions, no routes, no services, no Drush of its own —
its `configure` link points at the shared `entity.ad_entity.collection` list.

- **All config (per-entity fallback + global timeout), the view-alter swap, and the JS handler** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- `ad_entity_fallback.module`:
  - `hook_ENTITY_TYPE_view_alter()` → `ad_entity_fallback_ad_entity_view_alter()`: reads the
    entity's `ad_entity_fallback` third-party settings; if `ad_entity_id` is set, **clones** the
    referenced fallback entity, sets `disable_initialization = TRUE` on it, tags original and
    fallback containers with a correlated `data-fallback-container` / `data-fallback-container-for`
    attribute (`Crypt::randomBytesBase64(4)`), builds the fallback with the same `#variant`, and
    replaces `$build` with `[$build, $fallback_view]`.
  - `hook_form_BASE_FORM_ID_alter()` for `ad_entity_settings` and `ad_entity_form` → loads
    `ad_entity_fallback.admin.inc` and calls `_ad_entity_fallback_settings_form()` /
    `_ad_entity_fallback_entity_form()`.
  - `hook_page_attachments()`: sets `drupalSettings.ad_entity.fallback_timeout` (default 1000, or
    `ad_entity.settings:fallback.timeout`).
  - `hook_library_info_alter()`: injects `ad_entity_fallback/view` before ad_entity's `viewready`.
  - `hook_config_schema_info_alter()`: adds the `fallback` mapping (`timeout` integer) to
    `ad_entity.settings`.
- `ad_entity_fallback.install`: sets module weight to **1100** on install (its view-alter must run
  late) and clears ad_entity's cached plugin definitions on install/uninstall; uninstall also
  clears the `fallback` config key.
- `js/fallback.view.js` (library `ad_entity_fallback/view`, depends on `ad_entity/view`): on the
  `adEntity:collected` event, after `fallback_timeout` ms, correlates containers and, for any
  original that never initialized / is not in scope, enables + initializes the fallback container
  and marks the original as `fallbackProcessed`.
- Config schema `config/schema/ad_entity_fallback.schema.yml`: third-party key `ad_entity_id`
  (string) on `ad_entity.ad_entity.*`.

## Notes

- Fallback selection is **admin-side config** (a select on the entity form), gated by the same
  access as editing Advertising entities. The chosen entity is looked up by config id and rendered
  through the standard `ad_entity` view builder — no user/remote input is emitted.
- The swap is entirely client-side and timer-based; both containers are always present in the DOM.
