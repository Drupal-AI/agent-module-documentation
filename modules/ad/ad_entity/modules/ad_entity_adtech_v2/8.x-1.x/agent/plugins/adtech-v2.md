<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdTech Factory v2 type & view handler

Enable with `drush en ad_entity_adtech_v2 -y` (requires `ad_entity`). Configure under
`administer ad_entity`.

## `adtech_v2_factory` AdType (`AdtechType`)

### Global settings (`globalSettingsForm`, tab on the ad_entity global settings form)
- `async_tag` — textarea, the AdTech async tag "provided by ATF personnel"; output on non-admin
  pages by `hook_page_top()`.
- `layout_rules` — weighted repeater; each rule has a `rule_type`
  (`default` / `node_type` / `term_type` / `url_regex`) and a `layout` output value
  (`homepage` / `channel` / `article` / `gallery`) mapped to the `atf-contentType` dataLayer value.
  Node/term rules carry selected bundle checkboxes; url rules carry a `regex` (no validation — see
  the in-form warning). `sanitizeString()` normalizes the layout value on submit.
- `custom_slot` — repeater of named custom slots (name sanitized, umlauts/`&`/space replaced,
  `[^0-9a-z_-]` stripped, length-capped).
- `use_theme_breakpoints` (needs `theme_breakpoints_js`), `data_atf_use_lazy_load`,
  `data_atf_request_type` (`single_request`/`multi_request`), `page_targeting`.

### Per-ad settings (`entityConfigForm`, third-party settings)
- `data_atf_format` — select (`top`/`vertical`/`content`/`footer`/`custom`), required.
- `data_atf_format_size` — e.g. `1200x800`; required unless format is `custom`.
- `data_atf_custom_slot` — select from the globally defined custom slots.
- `data_atf_format_note` — `standard`/`special`/`native`/`special,native`.
- `entityConfigSubmit()` clears size when format is `custom`, clears custom slot when not `custom`,
  and clears `format_note` when `standard`. An attached `form_validation` JS library validates.

## `adtech_v2_default` AdView

`container=html`, `requiresDomready=true`. `build()` returns `#theme adtech_v2_default`.
`template_preprocess_adtech_v2_default()` (`ad_entity_adtech_v2.theme.inc`) builds an `Attribute`
object (`Html::getUniqueId($ad_entity->id())`) and sets `atf-format`, `atf-formatSize`,
`atf-formatNote`, `atf-customSlot` (from the ad) and `atf-requestType` (from global settings) via
`Attribute::setAttribute` (escaped). Template:
`<atf-ad-slot{{ attributes }}></atf-ad-slot>`, wrapped in a `data-slot` `slot-applicant` div
(JSON-encoded with `JSON_HEX_*`) when `use_theme_breakpoints` is on.

## Frontend wiring

- `hook_page_top()` → `$page_top['ad_entity_adtech_v2']['#markup'] =
  Markup::create($settings['async_tag'])` on non-admin routes (the provider bootstrap tag).
- `hook_page_attachments()` puts the non-tag global settings + merged `page_targeting` (collected
  from the context manager's `targeting` data via `_ad_entity_adtech_v2_array_merge_recursive_distinct`)
  into `drupalSettings.ad_entity_adtech_v2` and attaches `ad_entity_adtech_v2/init`.
- Libraries: `init` (header), `default_view`, `form_validation`, `layout_rules`.

## Config schema

`config/schema/ad_entity_adtech_v2.schema.yml` defines the third-party mapping and the
`ad_entity_adtech_v2.layout_rule.*` variants (`default`, `node_type`, `term_type`, `url_regex`).
The `adtech_v2_factory` mapping on `ad_entity.settings` is added at runtime via
`hook_config_schema_info_alter()`.
