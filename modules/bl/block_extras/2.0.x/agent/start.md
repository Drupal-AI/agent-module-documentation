<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Extras (block_extras) — agent index

Small site-building convenience module. Version **2.0.2**, `core_version_requirement: ^10.1 || ^11`, package `Custom`, license GPL-2.0-or-later.

## What it does
Adds a "Block Extras" fieldset to the core block placement/configure form (`block_form`) when the configured block is a placed **content block** (`block_content`). The fieldset contains an "Edit this block content" deep link and a live preview of the block's rendered content. Also provides a `hook_help()` about page.

## Shape
- **No** dependencies declared in `.info.yml` (implicit runtime use of core `block_content` for the preview/edit-link feature only).
- **No** permissions, routes, services, plugins, config settings, config schema, or Drush commands.
- Entire behavior lives in two hooks in `block_extras.module`:
  - `block_extras_help()` — about text for `help.page.block_extras`.
  - `block_extras_form_alter()` — alters `block_form`; builds the fieldset, the edit link, and the preview render array.
- Access is inherited from the core block form (users who can administer blocks); the module adds no access logic of its own.

## Solution docs
- [agent/api/form-alter.md](api/form-alter.md) — how the `block_form` alteration works, the content-block detection path, and the edit-link / preview render arrays.
