<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Menu Force enforces menu placement

Menu Force is implemented entirely as procedural form-alter hooks in `menu_force.module`.
There is no service, plugin, or constraint — just two form alters.

## 1. Content-type form: expose the toggles

`menu_force_form_node_type_form_alter()` adds two checkboxes into `$form['menu']`:

- `menu_force` — "Make the Menu Settings mandatory for this content type".
- `menu_force_parent` — "Lock the 'Default parent item' as well" (hidden via `#states`
  until `menu_force` is checked).

A `#validate` handler (`menu_force_form_node_type_form_validate`) errors if
`menu_force_parent` is set but no concrete `menu_parent` menu item was chosen. An
`#entity_builders` callback (`menu_force_form_node_type_form_builder`) writes both values
back as third-party settings on the `NodeType`.

## 2. Node add/edit form: enforce it

`menu_force_form_node_form_alter()` reads the node's type third-party settings and, when
`menu_force` is TRUE, alters the core `menu_ui` menu fieldset:

```php
$form['menu']['#open'] = TRUE;                       // fieldset forced open
$form['menu']['enabled']['#default_value'] = TRUE;    // "Provide a menu link" checked
$form['menu']['enabled']['#disabled'] = TRUE;         // ...and un-uncheckable
$form['menu']['link']['title']['#required'] = TRUE;   // menu link title required
// if menu_force_parent is also TRUE:
$form['menu']['link']['menu_parent']['#disabled'] = TRUE; // parent selector locked
```

Because the menu-link **title** becomes a required field, Drupal's normal form validation
blocks the save until the editor supplies one — that is the whole enforcement mechanism.
It relies on core `menu_ui` having already built `$form['menu']`; Menu Force's install weight
(1) guarantees it runs afterwards.

## Notes / edge cases

- Only affects the **node** add/edit form and the **node-type** form. Programmatic
  `Node::create()->save()` calls are **not** blocked — enforcement is UI-form-level only.
- The taxonomy equivalent lives in the `menu_force_taxonomy_menu_ui` submodule, which alters
  `taxonomy_term_form` / `taxonomy_vocabulary_form` the same way and stores settings on the
  vocabulary under provider `menu_force_taxonomy_menu_ui`.
