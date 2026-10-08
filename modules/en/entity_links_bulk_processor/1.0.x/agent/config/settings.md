<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, routes, permission & forms

Machine name `entity_links_bulk_processor`. Enable: `drush en entity_links_bulk_processor`. No
`configure` key in the `.info.yml`; reach settings via the routes below.

## Permission

`entity_links_bulk_processor.permissions.yml` defines one:

- **`administer entity links bulk processor`** — `restrict access: true`. Required by every route.
  Description states it grants access to modify content and configuration.

## Routes (`entity_links_bulk_processor.routing.yml`)

All require `_permission: 'administer entity links bulk processor'`.

| Route id | Path | Form class |
|---|---|---|
| `.admin` | `/admin/config/content/entity-links-bulk-processor` | `Form/EntityLinksBulkProcessorForm` |
| `.settings` | `.../settings` | `Form/SettingsForm` |
| `.process` | `.../process` | `Form/ProcessNowForm` |
| `.discover_css` | `.../discover-css-classes` | `Form/CssClassDiscoveryForm` |

Menu link `entity_links_bulk_processor.admin` under `system.admin_config_content`
(`.links.menu.yml`); `Settings` local task on the admin route (`.links.task.yml`).

## Config object `entity_links_bulk_processor.settings`

Install defaults in `config/install/entity_links_bulk_processor.settings.yml`; schema
(`config_object`) in `config/schema/entity_links_bulk_processor.schema.yml`. Keys (default in
parens):

- **Media / files**: `convert_file_paths` (false), `media_source_fields` (`field_media_file`,
  `field_media_document`, `field_media_image`, `field_media_audio_file`, `field_media_video_file`),
  `convert_img_to_drupal_media` (false), `convert_video_to_drupal_media` (false),
  `convert_d7_media_tokens` (false), `d7_media_default_view_mode` (`default`),
  `convert_media_src` (unset → false), `media_src_domains` (unset).
- **External / paths**: `convert_external_domains` (`[]`), `resolve_path_aliases` (true),
  `follow_redirects` (true), `check_entity_published` (true), `path_alias_format`
  (`preserve` | `system`).
- **Titles / anchors / styles**: `remove_matching_title_attrs` (false), `report_mismatched_titles`
  (false), `normalize_anchor_links` (true), `remove_inline_styles` (false),
  `remove_inline_styles_elements` (`a,p,div,span`),
  `remove_inline_styles_exclude_classes` (`keep-styles,preserve-formatting`).
- **Contact links**: `validate_mailto` (true), `validate_tel` (true), `validate_sms` (true),
  `validate_fax` (true), `tel_format` (`rfc3966` | `e164` | `dots`), `tel_country_code` (`1`).
- **CSS classes**: `enable_css_class_mapping` (false), `css_class_mappings` (sequence of
  `{from, to, scope, custom_selector, exclude}`; `scope` = element tag, `*`, or `custom`).
- **Multilingual**: `process_all_translations` (true), `process_languages` (`[]`),
  `resolve_cross_language_aliases` (false).
- **Logging / backup** (used by Drush/UI, tokens `[date]`/`[time]`): `backup_path` (`/tmp`),
  `backup_filename`, `success_log_path`/`success_log_filename`, `error_log_path`/
  `error_log_filename`, `enable_backup` (schema-only), `link_format` (`both` | `linkit` |
  `entity_links`; display/informational).

## Forms (behaviour)

- **`EntityLinksBulkProcessorForm`** (main): checkbox list of entity types with text fields
  (from `EntityTypeDiscovery::getEntityTypesWithTextFields`), AJAX bundle sub-options, optional
  entity IDs, a **Preview** action (`::preview` → `generatePreviewSamples`), a **Generate Drush
  Command** builder, and a link to Process Now. Preview before/after are rendered in read-only
  textareas.
- **`ProcessNowForm`**: 4 steps (`select`/`preview`/`confirm`/`results`). Confirm step requires a
  checkbox plus typing `PROCESS` (validated in `validateForm`). Submits a **batch** whose operations
  are `EntityLinksBulkProcessorForm::batchProcess`, finishing with `::batchFinished`; logs are written
  under `public://entity-links-logs/`.
- **`SettingsForm`** (`ConfigFormBase`-style; ~2,253 lines): edits all keys above; textareas map to
  the sequence configs (`convert_external_domains`, inline-style lists, CSS mappings). Includes a
  circular-mapping check (DFS) and links to the CSS discovery tool.
- **`CssClassDiscoveryForm`**: pick element types (or all common / include custom), min-occurrences,
  and sample size; calls `_entity_links_bulk_processor_discover_css_classes_all_elements`. Results
  table offers per-class **Import** (writes `css_class_mappings` via `importMappings`) and **Export
  to CSV** (`exportCsv`, streamed download). Class names are shown via `htmlspecialchars`.
