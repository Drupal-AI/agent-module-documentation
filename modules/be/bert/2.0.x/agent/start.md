<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Entity Reference Table (bert) — agent index

A friendlier **table form widget for `entity_reference` fields** plus a companion **selection
handler** and two **extensible plugin types**. Package `Fields`. Depends only on core
**`system` (>= 8.6)**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.3.
No routes, no permissions, no settings page, no Drush, no config schema — configured entirely on
a field's *Manage form display* and *field edit* pages.

## What it actually is (from source)

- **Widget** `bert` (`src/Plugin/Field/FieldWidget/Bert.php`, `@FieldWidget id="bert"`,
  `multiple_values = TRUE`, `field_types = {entity_reference}`). Renders referenced entities as a
  `#type => table` with per-row Remove button and (multi-value) drag weight; adds new items via
  Select / Radios / Autocomplete. Uses a custom render element `#type => 'bert'` and attaches
  library `bert/default` (css only).
- **Selection handler** `bert` (`src/Plugin/EntityReferenceSelection/BertSelection.php`, extends
  core `DefaultSelection`, `group="bert"`) with a **deriver**
  (`src/Plugin/Derivative/BertSelectionDeriver.php`) that yields one `bert:<entity_type>` per
  entity type. Choosing the bert widget auto-sets the field's `handler` to `bert:<type>` via
  `bert_entity_presave()` in `bert.module`.
- **Two plugin types** (managers in `bert.services.yml`):
  - `plugin.manager.entity_reference_list_formatter` — table-cell renderers, discovered under
    `Plugin/bert/EntityReferenceListFormatter`, `@EntityReferenceListFormatter` annotation, alter
    hook `hook_bert_entity_reference_list_formatter_alter()`.
  - `plugin.manager.entity_reference_label_formatter` — search-result label renderers, under
    `Plugin/bert/EntityReferenceLabelFormatter`, `@EntityReferenceLabelFormatter` annotation, alter
    hook `hook_bert_entity_reference_label_formatter_alter()`.
- **Install/update**: `bert_install()` migrates a legacy `wmbert` install (rewrites widgets +
  `wmbert`→`bert` handlers, uninstalls `wmbert`). `bert_post_update_8001()` cleans stale
  `entity_autocomplete` key_value rows. No `config/` at all.

## Solution docs

- **The widget — settings, add-modes, table build, AJAX add/remove** →
  [fields/widget.md](fields/widget.md)
- **The `bert:*` selection handler + deriver — extra options & query building** →
  [api/selection.md](api/selection.md)
- **The list/label formatter plugin types — built-ins, how to add your own, alter hooks** →
  [plugins/formatters.md](plugins/formatters.md)

Content-editing / form-widget module. It honors the field's target type and core entity access
(`accessCheck(TRUE)` in the selection query); it adds no access controls of its own.
