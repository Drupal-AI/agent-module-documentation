<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: AdTech Factory v2 (ad_entity_adtech_v2) — agent index

Current AdTech Factory provider for `ad_entity`. Submodule of **ad_entity**. Depends on
`ad_entity`; suggests `theme_breakpoints_js`. Package `Advertising`. Core `^9 || ^10 || ^11`.
GPL-2.0-or-later. Version 8.x-1.6 (dir `8.x-1.x`).

- **The `adtech_v2_factory` AdType, `adtech_v2_default` view, layout rules, custom slots** →
  [plugins/adtech-v2.md](plugins/adtech-v2.md)

## What it provides (from source)

- **1 AdType:** `adtech_v2_factory` (`src/Plugin/ad_entity/AdType/AdtechType.php`). Per-ad
  settings: `data_atf_format`, `data_atf_format_size`, `data_atf_custom_slot`,
  `data_atf_format_note`. Global settings: `async_tag`, `layout_rules` (weighted;
  default/node_type/term_type/url_regex), `custom_slot`, `use_theme_breakpoints`,
  `data_atf_use_lazy_load`, `data_atf_request_type`, `page_targeting`.
- **1 AdView:** `adtech_v2_default` (`src/Plugin/ad_entity/AdView/AdtechView.php`, `container=html`,
  `requiresDomready=true`, lib `ad_entity_adtech_v2/default_view`). `build()` → `#theme
  adtech_v2_default`.
- Theme hooks `adtech_v2_default` + `adtech_v2_piwik_pro_tag_manager_integration`
  (`ad_entity_adtech_v2.theme.inc`). Template `templates/adtech-v2-default.html.twig` renders
  `<atf-ad-slot{{ attributes }}>` (wrapped in a `slot-applicant` div when theme breakpoints are on).
- Config schema `config/schema/ad_entity_adtech_v2.schema.yml` (third-party settings + layout-rule
  types); `hook_config_schema_info_alter()` adds the `ad_entity.settings:adtech_v2_factory` mapping.
- `hook_ad_entity_module_info()`: `personalization: FALSE`, `consent_aware: FALSE` (ATF SDK's CMP
  handles it). `hook_page_top()` outputs the `async_tag` on non-admin routes;
  `hook_page_attachments()` passes global settings + page targeting to
  `drupalSettings.ad_entity_adtech_v2` and attaches the `init` library.

## Routes / permissions

No own routes. All configuration is through ad_entity's admin UI + global settings form, gated by
**`administer ad_entity`**. No `*.permissions.yml`.

## AJAX / form callbacks

Static form callbacks on `AdtechType` build the layout-rules and custom-slot repeaters:
`reloadRules`, `reloadSlots`, `addMore`, `removeLast` (all standard admin Form-API AJAX, no own
route). `sanitizeString()` normalizes slot/layout values on submit.
