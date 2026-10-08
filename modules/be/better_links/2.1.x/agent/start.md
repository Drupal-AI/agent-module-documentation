<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Links (better_links) — agent index

A single **field widget** that replaces core's Link widget and adds editor controls for a link's
**CSS class** and **`target`** attribute. Description: *"Provide a Link Field Widget with better
options."* Core requirement `^8 || ^9 || ^10 || ^11`. Depends only on core **`link`**. License
GPL-2.0-or-later. Version 2.1.x (2.1.0).

- **The widget, all its settings, the three class/target modes, config schema, and how to enable
  it** → [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `BetterLinksFieldWidget` (id **`better_links_field_widget`**, label *"Better Link"*),
  in `src/Plugin/Field/FieldWidget/BetterLinksFieldWidget.php`, extending core
  `Drupal\link\Plugin\Field\FieldWidget\LinkWidget`. `field_types = { "link" }` — core link fields
  only.
- **No** routes, **no** permissions, **no** services, **no** hooks, **no** `.module`/`.install`,
  **no** Drush, **no** submodules. The only non-PHP file of substance is the config schema
  `config/schema/better_links.schema.yml`.

## Mechanism (from source)

- `defaultSettings()` adds `better_links_class_mode` (`manual`), `better_links_class_force`
  (`btn btn-primary`), `better_links_class_select` (three `btn …|Label` lines),
  `better_links_target_mode` (`manual`), `better_links_target_force` (`_self`) on top of
  `LinkWidget::defaultSettings()`.
- `settingsForm()` renders radios + conditional inputs (`#states`) for each mode.
- `formElement()` injects the actual editor control into
  `$element['options']['attributes']['class']` and `['target']` depending on the configured mode
  (a `#type value` for *force*, a `select` for *select_class*/target, a `textfield`/`select` for
  *manual*). The value ends up in the link item's `options.attributes`, rendered later by core's
  link formatter (which escapes attributes).
- `getClassSelectOptions()` parses the textarea as `key|label` lines; `getTargetSelectOptions()`
  returns the fixed `_self/_blank/_parent/_top` map.

## Security

No routes, permissions, services, or endpoints — a pure form-display widget. Class/target values
are entered by editors who already hold field-edit access and are rendered as escaped HTML
attributes by core. No access-control, redirect, or injection surface.
