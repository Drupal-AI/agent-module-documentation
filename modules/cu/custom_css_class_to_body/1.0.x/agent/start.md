<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom CSS Class to Body (custom_css_class_to_body) — agent index

A tiny, **procedural (hook-only)** module that adds CSS class(es) to the `<body>` tag of node
pages. Everything lives in one file, `custom_css_class_to_body.module`. Package `Custom`. Core
requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4. Functionally
targets the core **`node`** entity; no dependencies are declared in `.info.yml`.

- **The two base fields, both form_alters, the validator, and the render-time preprocess** →
  [fields/body-class.md](fields/body-class.md)

## What it actually is

- **No** plugins, services, routes, permissions, Drush commands, config schema, config entities,
  libraries or submodules of its own. No `composer.json`, no `config/` dir. Just a `.module`,
  `.info.yml`, `README.md`, `LICENSE.txt`.
- Two **base fields** added to the `node` entity via `hook_entity_base_field_info()`:
  - `body_class` — `string`, translatable, label *"Add CSS class(es)"*, `string_textfield` widget.
  - `specific_node_class` — `boolean`, translatable, `boolean_checkbox` widget; when set, the node
    **type machine name** is appended as a body class.
- A per-**content-type** class stored as a third-party setting `node_type_class.classes` on the
  `NodeType` config entity (added on `node_type_edit_form`, saved by an `#entity_builders` callback).

## Mechanism (from source)

- `custom_css_class_to_body_form_node_form_alter()` — wraps `body_class` and `specific_node_class`
  in a `details` group ("Custom CSS Class to Body - Settings") in the node form's *advanced*
  sidebar; adds `_node_special_character_form_validate` to `#validate`.
- `custom_css_class_to_body_form_alter()` — on `node_type_edit_form` only, adds a "CSS class(es)"
  textfield defaulting to the existing `node_type_class.classes` third-party setting; registers
  `custom_css_class_to_body_form_node_type_form_builder()` (writes the setting back) and the same
  validator.
- `custom_css_class_to_body_preprocess_html()` — reads the current route's `node` param; appends to
  `$variables['attributes']['class']`: (1) `body_class` value, (2) the node type machine name when
  `specific_node_class == 1`, (3) the content-type `node_type_class.classes` string.
- `_node_special_character_form_validate()` — `preg_match` rejects a fixed set of special
  characters in `body_class` and `nodetype_class`; sets a form error if matched.
- `custom_css_class_to_body_help()` — help text on `help.page.custom_css_class_to_body`.

## Notes / caveats

- The content-type field is stored under the **`node_type_class`** third-party namespace and the
  node_type form attaches library `node_type_class/node_type_class.classes` — names borrowed from a
  separate contrib module. If that library is absent the attachment simply does not load; the
  stored value still works.
- `preprocess_html()` always pushes a class entry for the content-type setting (empty string when
  unset), so `class` may contain empty members; harmless in rendered markup.
- See [fields/body-class.md](fields/body-class.md) for install/enable, field details, the exact
  validator character set, and operation.
