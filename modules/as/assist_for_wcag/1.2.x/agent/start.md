<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assist For WCAG (assist_for_wcag) — agent index

Glue module that embeds a hosted third-party accessibility widget. An admin stores a token; the module injects `https://dockaccess.org/accessibility/<token>/start.js` (deferred) into the HTML head of every non-admin page.

- **Dependencies:** none (core only). PHP >= 8.1. Drupal `^10 || ^11 || ^12`. Package: Accessibility.
- **Config object:** `assist_for_wcag.settings` with one key, `token` (string). No config schema shipped.
- **Route:** `assist_for_wcag.settings` → `/admin/config/user-interface/assist-for-wcag`, form `AssistForWcagSettingsForm`, requires permission `administer site configuration` (core permission — module defines none of its own).
- **Menu link:** `assist_for_wcag.settings` under `system.admin_config_ui` (Configuration > User interface).
- **Hook:** `assist_for_wcag_page_attachments()` in `assist_for_wcag.module` — skips admin routes, then adds the remote `<script>` to `#attached['html_head']` when a token is set.
- **Library:** `assist_for_wcag/admin` (CSS only, `css/admin.css`) attached to the settings form.
- No entities, plugins, services, permissions, Drush commands, or submodules.

Solution docs:
- [config/settings.md](config/settings.md) — install, the settings form, the config object, and how the script injection works.
