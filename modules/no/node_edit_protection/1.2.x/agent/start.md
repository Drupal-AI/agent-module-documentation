<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Edit Protection — agent index

A zero-config JavaScript "unsaved changes" guard for **node add/edit forms**. Warns
*"You will lose all unsaved work."* via `window.onbeforeunload` when the form is dirty.
No settings form, config, permission, Drush, or plugin — enabling the module is the setup.

- **How the guard attaches and works; how to extend it to other forms** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- `hook_form_alter` attaches library `node_edit_protection/node_edit_protection` to any form
  whose `#attributes['class']` contains **`node-form`**.
- Library = `node-edit-protection.js`, deps `core/jquery` + `core/drupal`
  (`node_edit_protection.libraries.yml`).
- Dirty on any `.node-form :input` blur; submit buttons are allowed through; CKEditor dirtiness
  is detected via `CKEDITOR.instances[i].checkDirty()`.
