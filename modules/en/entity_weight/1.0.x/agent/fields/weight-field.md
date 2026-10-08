<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The weight field & `entity_weight_selector` widget

## The field
`field_entity_weight` is a core **`integer`** field, cardinality 1, created programmatically (see
[../config/settings.md](../config/settings.md), `entity_weight_create_field()`). It is
`translatable` and **`locked`** (not deletable through Field UI) and uses `persist_with_no_fields` so
the shared storage survives when the last bundle instance is removed until uninstall. Instance
`min`/`max` settings come from `entity_weight.settings`; default value is 0. There is **no custom
field type and no custom formatter** — the value is a plain integer, so any core integer formatter and
any Views field/sort handler works on it.

## The widget — `EntityWeightSelectorWidget`
`src/Plugin/Field/FieldWidget/EntityWeightSelectorWidget.php`, plugin id **`entity_weight_selector`**,
label *"Entity Weight Selector"*, `field_types = { "integer" }`, extends `WidgetBase`.

- `defaultSettings()` — `hidden => TRUE`.
- `settingsForm()` — one checkbox *"Hide weight field"*; `settingsSummary()` reports
  "Hidden on edit form" / "Visible on edit form".
- `formElement()`:
  - If `hidden` is TRUE → renders a `#type => hidden` element preserving the value (weight is then
    managed only from the ordering interface). This is the default when a bundle is enabled.
  - If visible → reads `min_weight`/`max_weight` from `entity_weight.settings`. When the range
    (`max - min`) is **≤ 40** it renders a `select` with one option per integer
    (`getWeightOptions()`); otherwise a `number` input with `#min`/`#max`/`#step 1`.

## Making the widget visible
Enabling a bundle sets the widget with `hidden => TRUE` on the default form display. To let editors
set weight while editing content, go to the bundle's *Manage form display*, open the Weight field
widget settings, and uncheck *Hide weight field*.

## Using in Views
Add **Sort criteria → `field_entity_weight`** (ascending = lightest first). No submodule is required
for a global weighted sort; the field is a standard integer field exposed to Views automatically.
For a per-view-display order that differs from the global weight, use the Entity Weight Views
submodule ([../../modules/entity_weight_views/1.0.x/agent/start.md](../../modules/entity_weight_views/1.0.x/agent/start.md)).
