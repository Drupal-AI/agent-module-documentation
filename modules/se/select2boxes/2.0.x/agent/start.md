# Select2 Boxes — agent index

Enhances Drupal select/entity-reference form elements with the [Select2](https://select2.org/) JS
library, per field (three widgets) or globally for all `<select>`s. Select2 loads from a configurable
CDN. Depends on core `field`. Config at `/admin/config/user-interface/select2boxes`
(`administer site configuration`). No permissions of its own, no Drush. Has a config schema and one
submodule.

- **Widgets, the global settings form, per-widget third-party options, CDN/library, auto-create, flags** →
  [configure/widgets.md](configure/widgets.md)

Submodule (own docs):
- `select2_bef` (Select2 for Better Exposed Filters) →
  [../../modules/select2_bef/2.0.x/agent/start.md](../../modules/select2_bef/2.0.x/agent/start.md)

Key facts:
- Field widgets: `select2boxes_autocomplete_single` & `select2boxes_autocomplete_multi`
  (`entity_reference`), `select2boxes_autocomplete_list` (`list_string`/`list_integer`/`list_float`/
  `language_field`).
- Config `select2boxes.settings`: `provider` (only `cdn`), `version`, `url`, `select2_global`,
  `disable_for_admin_pages`, `limited_search`, `minimum_search_length`.
- Global mode adds Select2 to every select via `template_preprocess_select`; the Select2 library is built
  dynamically in `hook_library_info_build` from the configured `url`/`version`.
- Per-widget third-party settings (`field.widget.third_party.select2boxes`): `enable_preload`,
  `preload_count`, `enable_flags`, `enable_select2` (address widgets).
