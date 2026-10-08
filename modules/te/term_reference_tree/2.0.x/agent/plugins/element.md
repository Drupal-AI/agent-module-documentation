<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Plugins: widget, formatter & the `checkbox_tree` element

The module defines **no plugin manager / plugin type** you extend. It ships two field
plugins plus one custom render element and its theme hooks.

## Field widget — `term_reference_tree`

`src/Plugin/Field/FieldWidget/TermReferenceTree.php`:

```php
@FieldWidget(
  id = "term_reference_tree",
  label = @Translation("Term reference tree"),
  field_types = {"entity_reference"},
  multiple_values = TRUE
)
```

Extends `WidgetBase`. `formElement()` builds a `checkbox_tree` render element, loading the
vocabularies named in the field's `handler_settings['target_bundles']` and passing widget
settings through as `#start_minimized`, `#leaves_only`, `#select_parents`, `#select_all`,
`#cascading_selection`, `#max_depth`, `#max_choices` (field cardinality), and
`#value_key = 'target_id'`. See [configure/widget.md](../configure/widget.md) for the
settings keys and defaults.

## Field formatter — `term_reference_tree`

`src/Plugin/Field/FieldFormatter/TermReferenceTree.php`:

```php
@FieldFormatter(
  id = "term_reference_tree",
  label = @Translation("Term Reference Tree"),
  field_types = {"entity_reference"}
)
```

Extends `FormatterBase`. No settings (`settingsSummary()` returns `[]`). `viewElements()`
renders non-empty values through `#theme => 'term_tree_list'` and attaches the
`term_reference_tree/term_reference_tree_css` library.

## Render element — `checkbox_tree` (`@FormElement`)

`src/Element/CheckboxTree.php` is the element the widget builds; you can also use it directly
in a custom form (see [api/render.md](../api/render.md)). Its `getInfo()` sets
`#input = TRUE`, `#tree = TRUE`, `#theme = 'checkbox_tree'`, a `processCheckboxTree` process
callback, and attaches libraries `term_reference_tree/term_reference_tree_js` (depends on
`core/jquery`, `core/drupal`, `core/once`) and `term_reference_tree_css`. Supporting element
classes: `CheckboxTreeItem`, `CheckboxTreeLabel`, `CheckboxTreeLevel`.

## Theme hooks

Registered in `term_reference_tree_theme()` with Twig templates in `templates/`:
`checkbox_tree`, `checkbox_tree_level`, `checkbox_tree_item`, `checkbox_tree_label`, and
`term_tree_list` (used by the formatter).

## What it does NOT provide

No hooks/`*.api.php`, no services you decorate, no Drush commands, no permissions of its own,
no config entity type, no plugin type. Integration points are: (1) selecting the widget on a
field's form display, (2) selecting the formatter on a field's display, and (3) reusing the
`checkbox_tree` render element in custom forms.
