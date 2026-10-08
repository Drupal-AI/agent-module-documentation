<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key Save — agent index

Adds a Ctrl-S / Cmd-S keyboard shortcut that submits Drupal config and entity forms by clicking their
primary submit button (works inside CKEditor too). No dependencies beyond core. Provides a config
schema; no permissions of its own (settings gated by `administer site configuration`); no Drush.

- **Which forms get the shortcut, the include/exclude config, and the JS behavior** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `hook_form_alter` attaches library `keysave/listen` to any form whose form object extends
  `ConfigFormBase` or `EntityForm`, plus any `form_id` in `include_forms`, minus any in `exclude_forms`.
- Config object `keysave.settings`: `include_forms` (sequence), `exclude_forms` (sequence).
- Settings route `keysave.settings` at `/admin/config/user-interface/keysave`, permission
  `administer site configuration`.
- JS (`js/listen.js`, deps `core/once`) clicks the first found of `edit-submit`, `edit-actions-submit`,
  `edit-save`, `edit-save-continue` on Ctrl/Cmd+S; validation/submit handlers still run.
