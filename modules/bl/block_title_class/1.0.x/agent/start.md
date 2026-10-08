<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Title Class (block_title_class) — agent index

Adds a per-block **select (None / h1-h6)** to the core block configuration form and appends the
chosen value as a **CSS class on the block title element** via `title_attributes`. No entities,
routes, services, permissions, plugins, or Drush — three procedural hooks in one `.module` file.

- **Version:** 1.0.x · **Core:** `^9 || ^10 || ^11` · **Package:** User interface
- **Requires:** `drupal:block` (core Block module) only. No composer requirements, no libraries.
- **Config storage:** block entity **third-party setting** `block_title_class.title_class`
  (schema `block.block.*.third_party.block_title_class`, `config/schema/block_title_class.schema.yml`).
  There is **no** module-level config object and **no** settings route (`configure: null`).

## What it provides (from `block_title_class.module`)

- `block_title_class_form_block_form_alter()` — adds a `Title Class` details group with a `select`
  (`#options`: `_none`, `h1`…`h6`) into `third_party_settings[block_title_class][title_class]`;
  registers `block_title_class_form_block_form_validate` as a `#validate` handler.
- `block_title_class_form_block_form_validate()` — `array_filter`s the group, merges it back into the
  form's `third_party_settings` value, and unsets the temporary `title_class` value.
- `block_title_class_block_presave()` — `hook_ENTITY_TYPE_presave` for `block`; normalizes the
  third-party setting (unsets when empty).
- `block_title_class_preprocess_block()` — loads the block by `#id`, reads the third-party setting,
  and when non-empty and not `_none` does `$variables['title_attributes']['class'][] = $title_class;`.

## Docs

- Configure it, the storage/schema, and the theme requirement →
  [config/settings.md](config/settings.md)

## Theme requirement

The block template must print the title attributes, e.g. `<h2{{ title_attributes }}>{{ label }}</h2>`
(see the module README). Themes whose block title omits `{{ title_attributes }}` show no effect.
