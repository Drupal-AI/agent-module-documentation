<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accesibilidad. Ticsmart (accesibility) — agent index
**Attaches a night-mode / simple-navigation accessibility widget to every non-admin page via a front-end library.**

- **Version:** 1.0.x (project `accesibilidad`; machine name `accesibility`)
- **Core:** ^9 || ^10
- **Route:** `accesibility.admin_settings_form` → `/admin/config/accesibility/adminsettings` (form `MessagesForm`), permission `access administration pages`.
- **Config:** `accesibility.adminsettings` (two message textareas).
- **Library:** `accesibility/accesibility-library`, attached in `accesibility_page_attachments()` for non-admin routes only.
- **Security:** single admin-gated settings form; no permissions.yml, no anonymous or mutating endpoints; purely presentational front-end. No security findings.
