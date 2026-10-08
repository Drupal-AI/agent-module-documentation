<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BugHerd (bugherd) — agent index

Injects the third-party **BugHerd** feedback/bug-reporting sidebar into site pages by
attaching its loader library. `hook_page_attachments()` publishes the project key + widget
config to `drupalSettings`, gated by the `access bugherd` permission (and optionally
suppressed on admin pages); `js/bugherd.js` then loads `sidebarv2.js` from bugherd.com.

- No dependencies (only core). Core: `^10 || ^11 || ^12`.
- Configure route: `bugherd.settings_form` → `/admin/config/development/bugherd`
  (permission `administer bugherd`).
- Defines 2 permissions. No drush, no plugins, no services (only a hook class). Has config schema.

Solution docs:
- **Set the project key / widget position / labels / admin suppression** → [configure/settings.md](configure/settings.md)
- **Who sees the widget vs. who can configure it** → [permissions/permissions.md](permissions/permissions.md)
- **How the widget is attached to pages (gating, drupalSettings, JS loader)** → [hooks/page_attachments.md](hooks/page_attachments.md)

Key facts:
- Config object: `bugherd.settings` (config schema `bugherd.settings`).
- Main keys: `bugherd_project_key`, `bugherd_widget_position` (`bottom-right`|`bottom-left`),
  `bugherd_disable_on_admin` (bool), `reporter_email_autofill` (bool), `email_required` (bool),
  plus 14 optional widget label overrides.
- Permissions: `administer bugherd`, `access bugherd`.
- Hook class: `\Drupal\bugherd\Hook\BugherdHooks` (`help`, `page_attachments`); legacy
  procedural wrappers in `bugherd.module` for D10.
- Library: `bugherd/bugherd` (`js/bugherd.js`, `header: true`). Cache tag: `bugherd`.
