<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns DS (ui_patterns_ds) — agent index

Renders a **Display Suite** field through a **UI Patterns component / SDC** instead of DS's own
field template. Version **1.0.0-alpha3** (**alpha**). Core `^10 || ^11`. License GPL-2.0-or-later.
Package *User interface*.

**Dependencies** (`ui_patterns_ds.info.yml`): `ui_patterns:ui_patterns`,
`ui_patterns:ui_patterns_layouts`, `ds:ds_extras`. Composer: `drupal/ds ^3.28`,
`drupal/ui_patterns ^2.0`.

**The gap it closes:** DS controls field arrangement and wrapping; UI Patterns/SDC define reusable
components. Without a bridge, everything can be a component *except* the field level, where DS
field templates take over and the design system stops applying. Only meaningful where both stacks
are already in use.

## What it provides (from source)

- **DS field template plugin** `ui_pattern_ds_component` — `src/Plugin/DsFieldTemplate/Component.php`
  (`#[DsFieldTemplate]`, theme `component`). The option shown on a field's *Manage display* gear;
  builds the component settings form via `ComponentFormBuilderTrait`.
- **UI Patterns source plugin** `ds_field` — `src/Plugin/UiPatterns/Source/DsField.php`
  (`#[Source]`, prop type `slot`). Returns the field's rendered value for a component slot.
- **Context provider service** `ui_patterns_ds.ds_field` — `src/ContextProvider/DsFieldContext.php`
  (tag `context_provider`), supplying `ui_patterns_ds:field` from the current request during the
  admin settings form.
- **Hooks** in `ui_patterns_ds.module`: `hook_preprocess_field__component()` (wires entity /
  field-name / field render-array source contexts), `hook_preprocess_ds_entity_view()`,
  `hook_config_schema_info_alter()` (adds a `ui_patterns` key to `layout_plugin.settings.ds.*`).
- **Theme/template** `component` → one-line `templates/component.html.twig` printing `{{ component }}`.
- **Config schema** `config/schema/ui_patterns_ds.schema.yml` — `ds.field_template.ui_pattern_ds_component`
  (type `ui_patterns_component`) and `ui_patterns_source.ds_field` (empty). No install config, no
  routes, no permissions, no Drush, no submodules.

## Solution docs

- **Enable it on a field, the field-template plugin, config/schema** →
  [config/field-template.md](config/field-template.md)
- **The `ds_field` source, the preprocess/context plumbing, render flow** →
  [plugins/ds-field-source.md](plugins/ds-field-source.md)
