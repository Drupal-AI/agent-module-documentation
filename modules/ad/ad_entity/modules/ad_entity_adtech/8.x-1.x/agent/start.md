<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertising Entity: AdTech Factory v1 (ad_entity_adtech) — agent index

**Deprecated** AdTech Factory provider for `ad_entity` (use `ad_entity_adtech_v2` for new work).
Submodule of **ad_entity**. Depends on `ad_entity`. Package `Advertising`.
Core `^9 || ^10 || ^11`. GPL-2.0-or-later. Version 8.x-1.6 (dir `8.x-1.x`).

- **The `adtech_factory` AdType + default/iframe/FIA AdView handlers, settings, templates** →
  [plugins/adtech.md](plugins/adtech.md)

## What it provides (from source)

- **1 AdType:** `adtech_factory` (`src/Plugin/ad_entity/AdType/AdtechType.php`) — per-ad settings
  `data_atf`, `data_atf_format`, default `targeting`, and iFrame `width/height/title`; global
  settings `library_source` + `page_targeting`.
- **3 AdView handlers** (`src/Plugin/ad_entity/AdView/`): `adtech_default` (`container=html`,
  `requiresDomready=false`, lib `ad_entity_adtech/default_view`), `adtech_iframe`
  (`container=iframe`), `adtech_fia` (`container=fia`, extends the iframe view).
- Theme hooks `adtech_default` / `adtech_iframe` (`ad_entity_adtech.theme.inc`,
  `ad_entity_adtech.iframe.inc`); templates `templates/adtech-default.html.twig` (a `<div>` with
  data attributes) and `adtech-iframe.html.twig` (a full `srcdoc` document loading the library).
- Config schema: `config/schema/ad_entity_adtech.schema.yml` (third-party settings under
  `ad_entity.ad_entity.*.third_party.ad_entity_adtech`) + `hook_config_schema_info_alter()` adds
  `ad_entity.settings:adtech_factory` (`library_source`, `page_targeting`).
- `hook_ad_entity_module_info()` declares `personalization: TRUE`, `consent_aware: FALSE`.
- `hook_library_info_build()` builds the external `provider` library from
  `adtech_factory.library_source`; `hook_page_attachments()` includes it (+ optional preload) and
  page targeting on non-admin routes. `hook_install`/`uninstall` clear ad_entity plugin caches;
  `hook_update_8001` converts stored page targeting from JSON string to array.

## Routes / permissions

No own routes. Ad + library configuration is done through ad_entity's admin UI and global
settings form, all gated by **`administer ad_entity`**. No `*.permissions.yml`.
