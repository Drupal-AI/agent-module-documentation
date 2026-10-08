<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IEF Complex Open (ief_complex_open) — agent index

One field widget that subclasses Inline Entity Form's "complex" widget so the **"add existing"
reference form is already open** when the widget first renders — saving editors the extra click on
the "Add existing …" button and making the UX resemble core's entity autocomplete. Version 1.x
(packaged 1.0.2). Trivial module: no routes, no services, no permissions, no Drush, no config
schema, no hooks, no `.module`/`.install` file, no plugin types of its own. It ships a single
field-widget plugin plus a small settings-form addition. Depends on contrib **Inline Entity Form**
(`inline_entity_form`, `^1 || ^3`).

## Solution docs

- **The widget: install, select it on a field, settings, and how "open by default" works** →
  [fields/widget.md](fields/widget.md)

## What it actually is

The whole module is one class,
`src/Plugin/Field/FieldWidget/InlineEntityFormComplexOpen.php`, which extends
`Drupal\inline_entity_form\Plugin\Field\FieldWidget\InlineEntityFormComplex`. Its `formElement()`
is a near-exact copy of IEF Complex 8.x-1.0-rc11 (the author marks the diffs with `Modifications:`
comments) that builds the reference/add-existing subform into the element by default instead of
behind a button, and relabels the create button to "Create new …". A custom static submit
`reference_form_submit()` (widget class, ~:538) guards the now-optional autocomplete against an
empty value before delegating to core `inline_entity_form_reference_form_submit()`.

- **Widget plugin:** id `inline_entity_form_complex_open`, label *"Inline entity form - Complex
  (Open)"*. Applies to field types `entity_reference` and `entity_reference_revisions`;
  `multiple_values = true`.
- **Use it:** on *Manage form display* (`/admin/…/form-display`) for any entity-reference field,
  set the field's widget to **"Inline entity form - Complex (Open)"**. No install/config step
  beyond that; enable the module first (`drush en ief_complex_open`). See
  [fields/widget.md](fields/widget.md).
- **Settings:** inherits every IEF Complex widget setting (`allow_new`, `allow_existing`,
  `allow_duplicate`, `match_operator`, `collapsible`, `collapsed`, `override_labels`, `label_*`,
  `removed_reference`, `add_existing_widget`, …). `defaultSettings()` and `settingsForm()` add one
  extra option: **`bundle`** — *"Restrict new inline entities to one bundle"* (default `''` = do
  not restrict), which pre-selects/limits the bundle used for inline creation.
- **Optional integration:** honors the `field_config_cardinality` third-party setting
  (`cardinality_config`) when the like-named contrib module is present (widget class, ~:103) —
  overriding effective cardinality; not a dependency.
