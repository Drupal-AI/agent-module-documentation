<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Manager (email_manager) — agent index

**Replaces Drupal outbound emails with admin-managed, token-enabled HTML templates keyed by `module:mail-key`.**

- **Version:** 1.0.x
- **Core:** `^10.3 || ^11 || ^12` (D10.3+). **Deps:** node, token, editor, ckeditor.
- **Permission:** `administer email templates` (restrict access) gates every route.
- **Configure:** `/admin/config/system/email-manager` (`email_manager.template_list`).
- **Routes:** template list/add/edit + key list/add/edit, all under `administer email templates`.
- **Entities:** `EmailTemplate`, `EmailKey` (config entities). **Mail plugin:** `EmailManagerMail`.
- **Tokens:** `email_manager:module`, `email_manager:key`.

**Security:** All routes require the restricted `administer email templates` permission; no anonymous or mutating public endpoints. Templates are admin-authored HTML rendered through Drupal's mail/token pipeline.

See [configure/templates.md](configure/templates.md).