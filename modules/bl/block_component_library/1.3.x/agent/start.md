<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Component Library (block_component_library) — agent index

A **configuration-only** site-building module: it adds one boolean field to custom
block types and installs a Views listing so editors can curate and bulk-manage custom
blocks flagged as reusable "components". No `src/`, no controllers, no services, no
plugins, no settings form. Package `Other`. License GPL-2.0-or-later. Version 1.3.2.

- **Full behavior: the field, the view, install/uninstall, permissions** →
  [config/field-and-view.md](config/field-and-view.md)

## Dependencies (`*.info.yml`)

`drupal:block`, `drupal:block_content`, `drupal:views`, and contrib
`views_bulk_operations:views_bulk_operations`. Core requirement `^8.9 || ^9 || ^10 || ^11`.

## What it actually provides

- **Field** `field_in_block_component_library` (boolean, label *"Add to Block Component
  Library"*) added to every `block_content` bundle. Storage + the `basic`-bundle instance
  ship in `config/install/`; `hook_install()` copies the instance to all other bundles.
- **View** `block_component_library` (`config/install/views.view.block_component_library.yml`),
  page display at **`/admin/content/block-content-component-library`** — a "Block Component
  Library" tab under **Content**. Lists reusable custom blocks with the flag set, with VBO
  bulk actions. Access = core permission **`administer blocks`**.
- **Local action** `block_content_add_action` ("Add custom block") on the view page,
  in `block_component_library.links.action.yml`.
- **Hooks**: `hook_help()` (module help text) in `.module`; `hook_install()` /
  `hook_uninstall()` in `.install`.

## What it does NOT provide

No settings route (`configure: null`), no permissions of its own, no Drush commands, no
config **schema**, no plugin types, no template/preview route, no custom PHP classes.
