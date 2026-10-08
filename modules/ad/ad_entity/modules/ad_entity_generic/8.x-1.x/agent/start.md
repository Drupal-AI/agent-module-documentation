<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: Generic ads (ad_entity_generic) — agent index

Submodule of **ad_entity**. Supplies a **provider-agnostic "generic" ad type** — a skeleton for
wiring custom/arbitrary ad implementations. Package `Advertising`. Depends on `ad_entity:ad_entity`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x` (release 8.x-1.6). Ships
the `ad_entity_generic_example` submodule. No permissions, no routes, no services of its own; the
`configure` link is the shared `entity.ad_entity.collection`.

- **The `generic` AdType + `generic` AdView plugins, the container markup, and the JS queue** →
  [plugins/generic.md](plugins/generic.md)
- **Global page-targeting setting and the inline targeting `<script>`** →
  [config/page-targeting.md](config/page-targeting.md)

## What it actually provides (from source)

- **AdType plugin** `GenericType` (`src/Plugin/ad_entity/AdType/GenericType.php`, id **`generic`**,
  label "Generic slot", extends `AdTypeBase`). Entity-config fields: `id` (Identifier, required),
  `format` (Display format, required), `targeting` (default key-value targeting, parsed by
  `TargetingCollection`). Global settings: `page_targeting.enabled` + `page_targeting.js_variable`
  (the js_variable is sanitized with `preg_replace('/[^a-zA-Z0-9\_]+/', '', …)`).
- **AdView plugin** `GenericJsView` (`src/Plugin/ad_entity/AdView/GenericJsView.php`, id
  **`generic`**, label "Generic ads via JavaScript", `library = ad_entity_generic/view`,
  `container = html`, `requiresDomready = FALSE`, `allowedTypes = {generic}`). `build()` returns
  `['#theme' => 'ad_entity_generic_js', '#ad_entity' => $entity]`; adds a
  `disable_initialization` checkbox to the entity form.
- **Theme** `ad_entity_generic_js` (`hook_theme` + `template_preprocess_ad_entity_generic_js()`),
  template `templates/ad-entity-generic-js.html.twig` = `<div{{ attributes }}></div>`. Preprocess
  builds a `Drupal\Core\Template\Attribute` with a unique id (`HtmlId::getUnique($settings['id'])`),
  class `adtag`, and `data-ad-format` = `$settings['format']`.
- **JS**: `ad_entity_generic/base` (`js/generic.base.js`, header) sets up
  `window.adEntity.generic` with `load`/`remove` and `loadHandlers`/`removeHandlers` queues;
  `ad_entity_generic/view` (`js/generic.view.js`) is the AdView handler that turns each `.adtag`
  container into an `ad_tag` object and pushes it to `adEntity.generic.load()`.
- **`hook_page_attachments()`**: on non-admin routes attaches `ad_entity_generic/base` when a
  `generic` view plugin is in use; if `generic.page_targeting.enabled`, emits an inline
  `<script id="page-targeting">` populating the configured global variable (see
  config/page-targeting.md).
- **Config schema**: third-party keys `id`, `format`, `targeting` on `ad_entity.ad_entity.*`
  (`config/schema/ad_entity_generic.schema.yml`); the `generic.page_targeting` mapping on
  `ad_entity.settings` is registered via `hook_config_schema_info_alter()`.
- **Install**: clears ad_entity cached plugin definitions on install/uninstall; uninstall clears
  the `generic` key from `ad_entity.settings`.

## Notes

- The generic view emits **no ad markup itself** — only an empty, attribute-only container `<div>`.
  Actual ad loading is external developer code registered on `window.adEntity.generic` (see the
  `ad_entity_generic_example` submodule for the handler pattern).
- All per-slot config (id, format, targeting) is set on the Advertising entity form and rendered
  through escaping `Attribute`/`Twig`; no user/remote data is emitted raw.
