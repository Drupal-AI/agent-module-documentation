<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdTech Factory (v1) type & view handlers

Deprecated provider. Enable with `drush en ad_entity_adtech -y` (requires `ad_entity`), then
configure the library and ads under `administer ad_entity`.

## `adtech_factory` AdType (`AdtechType`)

### Global settings (`globalSettingsForm`, tab on `/admin/structure/ad_entity/global-settings`)
- `library_source` — textfield, the external AdTech library URL (`src="…"`), embedded in `<head>`.
- `page_targeting` — default site-wide targeting in `pos: top, category: a` form, stored as an
  array via `TargetingCollection::collectFromUserInput()`.

### Per-ad settings (`entityConfigForm(AdEntityInterface)`, stored as third-party settings)
- `data_atf` — value for the `data-atf` attribute (default `tag`, required).
- `data_atf_format` — value for `data-atf-format` (e.g. `leaderboard`, required).
- `targeting` — default per-ad targeting (collection); on new ads defaults to
  `website: <site name>` (`defaultTargeting()` from `system.site`).
- The iFrame handler adds `iframe.width` / `iframe.height` / `iframe.title`.

`entityConfigSubmit()` parses the targeting textfield into a `TargetingCollection` and stores it
under `third_party.ad_entity_adtech.targeting.targeting` (or clears it when empty).

## AdView handlers (`src/Plugin/ad_entity/AdView/`)

| Plugin id | container | Notes |
|---|---|---|
| `adtech_default` | `html` | `requiresDomready=false`, lib `ad_entity_adtech/default_view`. `build()` → `#theme adtech_default`. |
| `adtech_iframe` | `iframe` | Renders a full `srcdoc` document; `build()` → `#theme adtech_iframe`. |
| `adtech_fia` | `fia` | Extends `AdtechIframe`; sets FIA title default + a targeting hint (`website`, `platform: FIA`, `channel: FIA`). |

## Rendering (theme preprocess)

- `template_preprocess_adtech_default()` (`ad_entity_adtech.theme.inc`): builds an `Attribute`
  object with a random id and the `data-atf` / `data-atf-format` attributes (added via
  `Attribute::setAttribute`, so escaped). On admin routes it also attaches page targeting.
  Template = `<div{{ attributes }}></div>`.
- `template_preprocess_adtech_iframe()` (`ad_entity_adtech.iframe.inc`): inlines the
  `ad_entity/base` JS (`_ad_entity_js_base_inline()`), sets the `data-atf*` attributes, and passes
  `library_source`, `page_targeting`, and the ad's filtered `targeting` JSON into the iFrame
  `srcdoc` (`templates/adtech-iframe.html.twig`), which loads the library and calls
  `atf_lib.load_tag()`. Targeting is filtered via `TargetingCollection::filter()` before output.

## Library loading

`hook_library_info_build()` synthesizes the `provider` library from
`ad_entity.settings:adtech_factory.library_source` (external, `async`). `hook_page_attachments()`
attaches `page_targeting` (as `drupalSettings.adtech_page_targeting`) + the provider library on
non-admin routes, and, when `tweaks.include_preload_tags` is on, a `<link rel=preload>` for the
library. All of this is admin-configured (global settings, `administer ad_entity`).

## Update path

`ad_entity_adtech_update_8001()` converts a legacy JSON-string `adtech_factory.page_targeting`
into an array (run `drush updb`, then re-export config).
