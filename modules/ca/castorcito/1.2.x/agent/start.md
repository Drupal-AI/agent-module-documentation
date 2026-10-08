<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito (castorcito) — agent index

No-code **component builder**. Site builders assemble reusable UI components (`castorcito_component`
config entities) from typed "cfields"; editors author them into a Drupal **JSON field** on any
content entity via a Vue widget, and they render on display through an overridable **Single
Directory Component (SDC)**. Package `Castorcito`. Version **1.2.1-beta5**, core `^10.2 || ^11`,
GPL-2.0-or-later. Maintained by SOFTWIN PERÚ. **Not covered by Drupal security advisories** (beta).

## Dependencies

- Drupal modules (info.yml): `json_field`, `rest`, `twig_tweak`, `file`, `image`, `help`.
- Composer/PHP libs: `drupal/json_field ^1.4`, `drupal/twig_tweak ^3.3`, `enshrined/svg-sanitize >=0.22 <1.0`.
- Front-end: Vue 3 loaded from the unpkg CDN (see `castorcito.libraries.yml` → `castorcito.widget`).

## What it provides

- **Config entities:** `castorcito_component` (config_prefix `component`) and `castorcito_category`
  (config_prefix `castorcito_category`). Both `admin_permission: administer castorcito component`.
- **Plugin type:** `CastorcitoComponentField` ("cfield"), manager service
  `plugin.manager.castorcito_component_field`; 12 core cfields (plain_text, formatted_text, image,
  link, boolean, number, list_text, iframe, entity_reference, block_reference, container,
  advanced_container). → [plugins/component-fields.md](plugins/component-fields.md)
- **Field integration:** a JSON-field **widget** `castorcito_component_widget` and **formatter**
  `castorcito_component_formatter` (both target field types `json`, `json_native`,
  `json_native_binary`). → [fields/widget-formatter.md](fields/widget-formatter.md)
- **Service:** `castorcito.manager` (`CastorcitoManager`) — component loading, drupalSettings
  assembly, block definitions, autocomplete URLs, usage queries.
- **REST resources:** `castorcito_ajax_upload_image_resource` (POST `/api/castorcito-ajax-upload-image`)
  and `castorcito_block_list_resource` (GET `/api/castorcito-block-list`).
  → [api/rest-and-services.md](api/rest-and-services.md)
- **Hooks:** `hook_form_alter` (injects the widget app), `hook_entity_access` /
  `hook_file_download` (private-file gating), `hook_entity_delete` (file-usage cleanup),
  `hook_theme`, `hook_preprocess_field/html`.
- **Permissions:** `administer castorcito component` (restricted), `use castorcito button paste`,
  `use castorcito button copy`. → [config/settings.md](config/settings.md)
- **SDC:** default SDC `castorcito:default_sdc` plus one SDC per cfield under `components/cfields/`.

## Routes

All under `/admin/castorcito/**`, gated by `administer castorcito component`: component &
category collections/add/edit/delete/clone, JSON model view, display-settings & override forms,
cfield add/edit/delete forms, "in use" modal/page. Full list in
[config/settings.md](config/settings.md).

## Sub-modules (each documented separately under `modules/<sub>/1.2.x/`)

- **castorcito_basepack** — ready-made components (banner, card, tabs, accordion, carousel,
  gallery, quote, video, …). → [../castorcito_basepack/1.2.x/agent/start.md](../castorcito_basepack/1.2.x/agent/start.md)
- **castorcito_advancedpack** — advanced components (Swiper slider, timeline). → [../castorcito_advancedpack/1.2.x/agent/start.md](../castorcito_advancedpack/1.2.x/agent/start.md)
- **castorcito_date** — `date` cfield. → [../castorcito_date/1.2.x/agent/start.md](../castorcito_date/1.2.x/agent/start.md)
- **castorcito_webform** — `webform` cfield embedding a Webform. → [../castorcito_webform/1.2.x/agent/start.md](../castorcito_webform/1.2.x/agent/start.md)
- **castorcito_sync** — export/import components as a config tarball. → [../castorcito_sync/1.2.x/agent/start.md](../castorcito_sync/1.2.x/agent/start.md)

## Notes

- Widget/formatter only appear on **JSON** fields (`json_field` module), not core text fields.
- README: incompatible with the Klaro Cookie & Consent Manager module.
