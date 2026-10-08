# Configure Diff

![Diff general settings form](../../../../../../../screenshots/diff/2.1.x/settings.png)

Two config forms; all state lives in `diff.settings` (config object, schema in
`config/schema/diff.schema.yml`).

## General settings — route `diff.general_settings` (`/admin/config/content/diff/general`)
Form: `src/Form/GeneralSettingsForm.php`. Permission: `administer site configuration`.
Keys under `general_settings`:
- `radio_behavior` — revision-overview radio selection mode (`simple`).
- `context_lines_leading` / `context_lines_trailing` — context lines around each change (default 1/1).
- `revision_pager_limit` — revisions per page in the diff pager (default 50).
- `layout_plugins` — map of layout id → `{enabled, weight}`. Ships `visual_inline` (off),
  `split_fields` (on, w1), `unified_fields` (on, w2).
- `visual_default_view_mode` — view mode used to render the visual inline diff (`full`).
- `visual_inline_theme` — theme for the visual inline layout (`default`).

## Fields settings — route `diff.fields_list` (`/admin/config/content/diff/fields`)
Form: `src/Form/FieldsSettingsForm.php`. Assigns a FieldDiffBuilder plugin + per-plugin
settings to each field type, stored in the `diff.plugins` config object. Per-field options
(schema `diff.plugin.settings.*`) include e.g. `compare_format` (text), `compare_summary`
(text w/ summary), `show_thumbnail`/`compare_alt_field` (image), `compare_uri`/`compare_title`
(link), `compare_entity_reference`, `show_id` (file). Base options: `show_header`, `markdown`.

## As config
`config/sync/diff.settings.yml` mirrors the `general_settings` tree above (see
`config/install/diff.settings.yml` for the shipped defaults); import with `drush config:import`.
