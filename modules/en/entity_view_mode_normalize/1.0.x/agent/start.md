<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity View Mode Normalize — agent index

Serialization normalizers (core `serialization`/`rest` pipeline) that render an entity through a **view
mode**: output the fields enabled in a view display, each passed through its formatter, instead of raw stored
values. Version 1.0.2 (`1.0.x`). Core `^10 || ^11`. Depends on core `rest`.

- No API code you call directly — these are tagged `normalizer` services + Views row plugins that activate
  automatically once the module is enabled and a view mode is selected.
- View mode is chosen by `?_view_mode=<machine_name>` on the request, or by serialization context
  (`$context['field']['settings']['view_mode']`) set by a Views row plugin or a referencing field.
- Config route `entity_view_mode_normalize.config_form` (`/admin/config/services/rest/simple-entity-serialize`)
  exists but is a non-functional stub (no real settings); it is not declared as the module's configure link.

## Docs
- `agent/api/normalizers.md` — the normalizer set: view-mode selection, per-field-type behavior
  (text, link, entity reference, file, select/list), cardinality collapsing, output shapes.
- `agent/api/views.md` — the two Views "data" row plugins (`view_mode_data_entity`,
  `search_api_data_entity_row`) and the `telephone_validation_normalize` submodule.

## Not provided
No permissions, no Drush commands, no config schema, no new plugin types, no services you construct. Read
those as absent — do not search for them.
