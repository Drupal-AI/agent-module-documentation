<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mobile Native Share (mobile_native_share) — agent index

Adds a **"Share" button** to content-entity displays that invokes the browser **Web Share API**
(`navigator.share`), with clipboard/`prompt()` fallbacks. Version **1.x** (installed 1.2.1).
Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Package: none declared.

No required module dependencies (declares none in `.info.yml`). **Optional**: `drupal/token`
enhances the settings form (token browser) and per-bundle Title/Description token replacement.

## What it provides

- **Config settings form** `MobileNativeShareSettings` (route `mobile_native_share.admin_settings`,
  path `/admin/config/search/mobile-native-share`, permission `administer mobile native share`).
  Writes config object `mobile_native_share.settings`.
- **Renderer service** `mobile_native_share.renderer` (class `MobileNativeShareRenderer`, interface
  `MobileNativeShareRendererInterface`) — `render(?EntityInterface $entity = NULL): array` builds the
  button render array.
- **Hooks** (in `src/Hook/MobileNativeShareHooks.php`, wired via `#[Hook]` + `#[LegacyHook]`):
  `hook_theme` (`mobile_native_share`), `hook_theme_suggestions_HOOK`,
  `hook_entity_extra_field_info` (adds the "Native share button" display component to enabled
  bundles), `hook_entity_view` (renders it when the component is placed), `hook_help`.
- **Alter hook** `hook_mobile_native_share_entity_types_alter(array &$entity_types)`
  (`mobile_native_share.api.php`) — extend the default entity-type list
  (`comment`, `node`, `taxonomy_term`).
- **Theme/template** `mobile_native_share` → `templates/mobile-native-share.html.twig`.
- **Asset library** `mobile_native_share/share-button` (`js/share-button.js`,
  `css/share-button.css`; deps `core/drupal`, `core/once`).
- **Permission** `administer mobile native share` (restrict access).
- **Update hook** `mobile_native_share_update_10001()` backfills `display_mode`.

## Solution docs

- Settings, config object + schema, the display component, tokens, icon validation →
  [config/settings.md](config/settings.md)
- Renderer service, template, JS behavior, theme suggestions, the alter hook →
  [api/renderer.md](api/renderer.md)

## Notes

- No routes other than the settings form; no controllers, no Drush, no submodules, no external JS
  libraries. Button URL is the entity's canonical absolute URL, or the current request URI when no
  entity is available.
