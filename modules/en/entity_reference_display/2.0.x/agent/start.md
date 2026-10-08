<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_reference_display — agent start

Field type `entity_reference_display` (label "Display mode") stores ONE view-mode
machine name (`varchar(255)`, e.g. `default`/`teaser`/`full`) as a string. Editors pick
it; a companion formatter renders an entity reference field with that chosen mode.
No global config UI (`configure` is null) — everything is per-field on a bundle.
Depends on core `options`; reuses `list_string` widgets/formatters.

Pieces:
- Field type `entity_reference_display`, default widget `options_select`, cardinality locked to 1.
- Field settings `exclude` (view modes to hide) and `negate` (flip exclude into an allow-list).
- Formatter `entity_reference_display_default` ("Selected display mode") placed on the
  entity_reference / entity_reference_revisions field; setting `display_field` picks which
  display-mode field drives it when several exist.

- Add & configure the Display mode field + the Selected display mode formatter → [configure/field.md](configure/field.md)
- Field type/formatter ids, storage schema, settings & how to read/set in code → [api/api.md](api/api.md)
