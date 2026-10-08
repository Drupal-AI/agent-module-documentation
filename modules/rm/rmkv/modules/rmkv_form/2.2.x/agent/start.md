<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rmkv_form (Remove system.schema key/value Form) — agent index

Submodule of the **rmkv** project. Adds one admin form that does the same job as rmkv's Drush
commands — deleting an orphaned entry from the `system.schema` key/value collection (Drupal's record
of an extension's last-run schema version, left behind when its code is removed without first being
uninstalled). Version **2.2.0**. Core `>=10`, PHP `>=8.1`. Self-contained: it re-implements the
logic with core services and declares **no** module dependency, so the parent `rmkv` module need not
be enabled.

- **The removal form, its route and menu link** → [configure/form.md](configure/form.md)
- **The access permission** → [permissions/access.md](permissions/access.md)

Key facts:
- Route `rmkv_form.form` → `/admin/config/development/rmkv`, `_form: Drupal\rmkv_form\Form\RemoveKeyValueForm`, `_admin_route: TRUE`.
- Gated by the permission `access to rmkv form` (`restrict access: TRUE`).
- Menu link under Configuration ▸ Development (`system.admin_config_development`).
- `configure` route = `rmkv_form.form` (declared in `rmkv_form.info.yml`).
- Single `machine_name` field `system_schema_key_value_machine_name`; on submit it deletes that name from the `system.schema` store, with the same installed-extension guard as the Drush command.
