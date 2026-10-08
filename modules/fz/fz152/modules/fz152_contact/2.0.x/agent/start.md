<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — Contact — agent index

Attaches the FZ152 consent checkbox to core Contact forms. Depends on `fz152` + core `contact`.
No own permission (reuses `administer fz152`), no plugins, no Drush. Config UI
`fz152.settings.contact` at `/admin/config/system/fz152/contact`.

- **Per-bundle settings, config object shape, and how bundles become form ids** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Per contact bundle config: `fz152_contact.settings.<bundle>` — `enabled` (bool), `weight` (int),
  `checkbox_title` (int 1–10), `langcode`.
- `Fz152ContactService::getForms()` returns enabled bundles as `contact_message_<bundle>_form`;
  the **parent** `fz152.module` `hook_form_alter` does the actual checkbox injection.
- Registers a `config_translation` group (`fz152.settings.contact` base route).
