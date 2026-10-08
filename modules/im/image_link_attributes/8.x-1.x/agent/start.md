<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Link Attributes (image_link_attributes) — agent index

Extends core's **image** and **responsive_image** field formatters so a linked image's anchor can
carry `class`, `target` and `rel` attributes, and optionally link to an alternate image style.
Package `Media`. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.11.
Depends on core **`image`** and **`link`**. **No PHP classes, no plugins, no routes, no permissions** —
it is hooks, two Twig templates and one config object.

- **How the attributes are added, every setting, the config object, and the render path** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- It does **not** define its own field formatter. It hooks the existing core `image` and
  `responsive_image` formatters via `hook_field_formatter_third_party_settings_form()` and
  `hook_field_formatter_settings_summary_alter()` (in `image_link_attributes.module`), adding
  third-party settings under key `image_link_attributes` on the Manage display form.
- `hook_preprocess_field()` reads those third-party settings and merges the chosen attribute values
  into the render array's `#link_attributes` (and sets `#alternate_path` for the alternate image
  style). `hook_theme()` + `hook_theme_registry_alter()` override the `image_formatter` and
  `responsive_image_formatter` templates (in `templates/field/`) so they pass `link_attributes`
  (and `alternate_path`) into the Twig `link()` function.
- Which attributes editors may set is read from config object **`image_link_attributes.config`**
  (`targets` and `attributes` maps; defaults in `config/install/`, schema in `config/schema/`).
  Ships `target` (select: `_blank`/`_self`/`_parent`/`_top`), `class`, `rel`.

## Notes

- `configure:` in the `.info.yml` points at route id `image_link_attributes.config`, but the module
  ships **no `*.routing.yml`** — there is no admin form for that config; edit it via config
  import/`drush cset` if the offered attribute list must change.
- Attribute values are placed into `#link_attributes` and rendered by core's `link()` Twig
  function, so they are escaped by Drupal's Attribute handling.
