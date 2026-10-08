<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tac_lite_create — agent index

Submodule of **tac_lite**. Hides taxonomy **term options** a user may not use on node add/edit
forms (via `hook_form_alter`), instead of the parent's node_access approach. Depends on
`tac_lite`. No config page, permission, service, route, or schema of its own.

- **Enable form-term visibility per scheme & where the flag lives** →
  [configure/visibility.md](configure/visibility.md)

Key facts:
- Adds a **"Visibility on create and edit forms"** checkbox to each tac_lite scheme tab; the
  value is stored inside the parent config as
  `tac_lite.settings:tac_lite_config_scheme_<n>.tac_lite_create` (boolean).
- On node forms it removes term options not in the user's allowed tids for any scheme where
  `tac_lite_create` is on **or** that grants `update`; `select`/`radios`/`checkboxes` widgets
  only. Users with `administer tac_lite` see all terms; a term that is the field's current
  default value is never stripped.
- It controls *which terms appear*, not *who can create content* (use core permissions for that).
