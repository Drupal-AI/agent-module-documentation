<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ad_entity` and `ad_display` config entities

Two `ConfigEntityType`s in `src/Entity/`. Both use `Drupal\entity`'s
`EntityAccessControlHandler` + `EntityPermissionProvider`, `admin_permission =
"administer ad_entity"`, and custom route providers (`AdEntityHtmlRouteProvider`,
`AdDisplayHtmlRouteProvider`, both extend core `AdminHtmlRouteProvider`).

## `ad_entity` (class `AdEntity`)

- Config prefix `ad_entity`; `config_export`: `id`, `label`, `type_plugin_id`, `view_plugin_id`,
  `disable_initialization`. Links under `/admin/structure/ad_entity/…`; collection
  `/admin/structure/ad_entity`.
- Binds a **type plugin** (`getTypePlugin()` via `ad_entity.type_manager`) and a **view handler
  plugin** (`getViewPlugin()` via `ad_entity.view_manager`). `calculateDependencies()` adds the
  view plugin's provider module as a config dependency.
- **Targeting/context accessors:** `getContextData()`, `getContextDataForPlugin($id)`, and
  `getTargetingFromContextData()` (returns a `TargetingCollection` built from the `targeting`
  context data, merged with third-party-settings context via `getThirdPartyContextData()`).
- Cache: `getCacheTags()` adds `config:ad_entity.settings` and merges tags of the entities
  "involved" in providing context (tracked by `AdContextManager`); `getCacheContexts()` adds
  `url.path`.

### View builder

`AdEntityViewBuilder::view()` (`src/AdEntityViewBuilder.php`) sets **no cache keys** (an Ad entity
may appear many times per page; see the in-file comment). It normalizes the view mode into a JSON
variant string (`["any"]`, `["mobile"]`, …), and if a `turnoff` context applies it returns an
empty (cache-only) build. Otherwise it builds `#theme => 'ad_entity'`, `#ad_entity`, `#variant`
and runs `hook_ad_entity_view_alter`.

`template_preprocess_ad_entity()` (`ad_entity.theme.inc`) calls the view plugin's `build()` for
`#content`, and — only for `container === 'html'` — generates a random container id
(`Crypt::randomBytesBase64`), the `ad-entity-container` classes, `data-ad-entity*` attributes, and
the `data-ad-entity-targeting` JSON (from `getTargetingFromContextData()->filter()->toJson()`).
Template `templates/ad-entity.html.twig` renders the `html`, `fia` (`<figure class="op-ad">`) or
raw container.

## `ad_display` (class `AdDisplay`)

- Config prefix `display`; `config_export`: `id`, `label`, `theme_canonical`, `variants`,
  `fallback`. `variants` maps **theme → { ad_entity_id → breakpoint-JSON }**.
- `getVariantsForTheme(ActiveTheme)` resolves which ads to show for the active theme, honoring
  `fallback.use_settings_from` and `fallback.use_base_theme`.
- `calculateDependencies()` adds `config: ad_entity.ad_entity.<id>` for each referenced ad.
- `postSave()`/`delete()` clear the block plugin cache (the display is exposed as a block
  derivative — see below).
- `AdDisplayViewBuilder::view()` loads each variant's Ad entity and, **gated on
  `$ad_entity->access('view')`**, adds its render array under `#variants`; template
  `templates/ad-display.html.twig` just prints `{{ variants }}`.

### Canonical route / iFrame

`AdDisplayHtmlRouteProvider::getCanonicalRoute()` defines `/ad-display/{ad_display}` →
`AdDisplayController::view()` with `_entity_access: ad_display.view`. The controller switches to
`theme_canonical` (falls back to the site default), renders the display, and attaches a
`robots: noindex,follow` meta tag. This URL is what `ad_display_iframe` uses as the iframe `src`
(`template_preprocess_ad_display_iframe`; unsaved displays log an error and render a placeholder
`srcdoc`).

## Blocks

`src/Plugin/Block/AdDisplayBlock.php` + `AdDisplayIframeBlock.php`, with derivatives from
`src/Plugin/Derivative/AdDisplayBlock.php` (one block per saved `ad_display`). Place them at
`/admin/structure/block`. `hook_block_build_ad_display_alter()` strips `#cache[keys]` (mirrors the
view-builder's no-cache-keys strategy).
