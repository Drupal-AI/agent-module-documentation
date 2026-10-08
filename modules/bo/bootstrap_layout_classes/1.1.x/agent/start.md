<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Layout Classes (bootstrap_layout_classes) — agent index

A field **widget + formatter** pair for choosing Bootstrap layout/utility classes and rendering
them as classes on the entity wrapper. Package `Fields`. Depends only on core **`field`**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- **The widget** (class-selection UI, settings, value serialization) →
  [fields/widget.md](fields/widget.md)
- **The formatter + render hook** (how classes reach the entity) →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One widget plugin: `BootstrapLayoutClassesWidget` (id **`bootstrap_layout_classes_widget`**),
  `field_types = { "string", "text" }`, in `src/Plugin/Field/FieldWidget/`.
- One formatter plugin: `BootstrapLayoutClassesFormatter` (id
  **`bootstrap_layout_classes_formatter`**), `field_types = { "string", "text", "list_string" }`,
  in `src/Plugin/Field/FieldFormatter/`.
- `bootstrap_layout_classes.module`: `hook_help()`, `hook_entity_view_alter()` and helper
  `_bootstrap_layout_classes_apply()` — the hook is what actually adds classes to the render array.
- Config schema for widget settings only: `config/schema/bootstrap_layout_classes.schema.yml`
  (`field.widget.settings.bootstrap_layout_classes_widget`). One CSS library `form_style`
  (`css/style.css`) attached by the widget.
- **No routes, no permissions, no services, no admin settings form, no Drush, no submodules.**
  `configure` is null. All configuration is per field-display.

## How to use (from README / hook_help)

1. Add a plain-text field, cardinality 1 (e.g. `field_layout`) to a content or paragraph type.
2. On the **form display**, set its widget to *Bootstrap Layout Classes*; use the widget settings
   to choose which class groups editors may set.
3. On the **view display**, hide the label and set the formatter to *Bootstrap Layout Classes*.
   The stored classes are added to the entity wrapper; the raw value is not printed. Clear caches
   after changing the formatter.

## Security-relevant note (mechanism, not a finding)

Stored class tokens are space-split and each is passed through
`\Drupal\Component\Utility\Html::getClass()` before being added to `#attributes['class']` in
`_bootstrap_layout_classes_apply()`, and Drupal escapes attribute values on render — so the free-text
"custom classes" box cannot inject markup. No external HTTP, no request-supplied paths, no SQL.
