Select2 integrates the Select2 JavaScript library into Drupal, providing a searchable, tag-style replacement for plain `<select>` and entity reference fields plus a reusable `select2` form render element.

---

Select2 turns ordinary select boxes into rich, searchable widgets. It ships two field widgets — `select2` for list fields (`list_integer`, `list_float`, `list_string`) and `select2_entity_reference` for entity reference fields — and a `#type => 'select2'` render element you can drop into any form. For entity reference fields the widget adds two big features on top of core: **autocomplete**, where options are lazy-loaded over AJAX (via a hashed `select2.entity_autocomplete` route) instead of rendered up front, so it scales to thousands of entities; and **autocreate/tags**, where typing a new label creates the referenced entity on the fly (mirroring core's entity-reference autocomplete). The render element sets sensible Select2 defaults (placeholder, clear button, RTL/i18n direction, per-theme styling, max-selection from field cardinality) that you can override per-property via `#select2`. It depends on the external Select2 JS library (installed under `/libraries/select2`), wired up through `select2.libraries.yml` and `hook_library_info_alter`, and provides Claro/Gin/Seven theme integrations. Two submodules extend it: **Select2 Facets** (a Select2 widget for the Facets module) and **Select2 Publish** (marks referenced entities with their published status in the dropdown). Multiple selections are drag-reorderable via `core/sortable`.

---

- Replace a long single-select dropdown with a searchable Select2 box.
- Add type-to-filter search to a taxonomy or content-type select field.
- Use `select2_entity_reference` widget on an entity reference field for a tag-style multi-select.
- Lazy-load reference options over AJAX (autocomplete) so a field with thousands of targets stays fast.
- Let editors create new taxonomy terms on the fly by typing them (autocreate/tags).
- Enter a comma-separated list of tags that become referenced entities on save.
- Drag to reorder multiple selected entities before saving.
- Cap how many items can be selected using the field's cardinality.
- Add a `#type => 'select2'` element to a custom form for a searchable select.
- Build a single-select or multi-select custom form widget with a placeholder and clear button.
- Override any Select2 config option (e.g. `allowClear`, `minimumInputLength`) via the `#select2` property.
- Provide right-to-left and translated Select2 UI automatically per the current language.
- Match autocomplete suggestions with "Starts with" or "Contains" and limit the number of results.
- Wire a custom autocomplete route/options callback with `#autocomplete_route_callback` / `#autocomplete_options_callback`.
- Style the widget to match Claro, Gin, or Seven admin themes out of the box.
- Ship a custom Select2 skin by declaring a `select2.theme` library in your theme.
- Alter autocomplete match results in code via `hook_select2_autocomplete_matches_alter()`.
- Call the `select2.autocomplete_matcher` service to get entity match results programmatically.
- Group options into optgroups in a Select2 element.
- Add a searchable Select2 widget to a Facets facet block (Select2 Facets submodule).
- Autocomplete facet values instead of listing them all (Select2 Facets).
- Show published/unpublished status of referenced entities in the dropdown (Select2 Publish submodule).
- Warn editors when they reference an unpublished entity (Select2 Publish).
- Use Select2 as a Better Exposed Filters widget for Views exposed filters.
- Set a fixed width (px, %, em, or `element`/`resolve`) for the widget.
- Deploy widget settings (width, autocomplete, match operator/limit) as field-widget configuration between environments.
