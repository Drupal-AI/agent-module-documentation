<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Map Widget (map_widget) — agent index

Developer module. Supplies the missing form widget + render element for Drupal core's `map`
field type (a field that stores a serialized associative array — core ships no widget for it).
An editor gets a repeatable key/value table on the entity form; the values are saved back into
the map field as a `key => value` PHP array. No geographic maps are involved despite the name.

Core only (`^10.3 || ^11`), no other module dependencies. No settings page (`configure` null),
no permissions, no Drush, no services, no routes. Provides per-instance widget settings and a
config schema for them.

- **Attach the widget to a `map` base field + its settings (size, placeholders), add-more/AJAX
  behavior, stored value shape** → [fields/widget.md](fields/widget.md)
- **Reuse the `map_associative` form element directly in a custom form** →
  [api/element.md](api/element.md)

Key facts:
- Field widget plugin id **`map_assoc_widget`** → `AssociativeArrayWidget`
  (`src/Plugin/Field/FieldWidget/AssociativeArrayWidget.php`), attribute
  `#[FieldWidget(id: 'map_assoc_widget', field_types: ['map'], multiple_values: TRUE)]`.
  (Its declared `label` is the stray string `'Single on/off checkbox'` — a copy-paste
  leftover, not descriptive.)
- Render element **`map_associative`** → `AssociativeArray`
  (`src/Element/AssociativeArray.php`), attribute `#[FormElement('map_associative')]`.
  Properties: `#count`, `#size`, `#key_placeholder`, `#value_placeholder`.
- Widget settings (also the config-schema keys under
  `field.widget.settings.map_assoc_widget` in `config/schema/map_widget.schema.yml`):
  `size` (int, default 60), `key_placeholder` (string), `value_placeholder` (string).
- Library **`map_widget/associative_element`** (`css/associative-element.css`) styles the
  key/value rows; auto-attached by the element.
- `map_widget.install` provides ONLY the update hook `map_widget_update_8101()` (with helper
  `_map_widget_map_fixer()`) that repairs recursively-nested/corrupted map data written by an
  older buggy version. There is no `hook_install`.
- The core `map` field is not exposed in Field UI; it is added as a base field in code, so the
  widget is selected via `setDisplayOptions('form', ['type' => 'map_assoc_widget', ...])` or on
  the entity's form display where such a base field exists.
