<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Load Progress — agent index

Full-screen throbber/lock overlay shown while a slow page reload or form submit is in progress.
Pure UI, jQuery-based, no external deps. `configure` = `page_load_progress.admin_settings`.
Provides two permissions and a config schema; no plugins, no Drush, no services.

- **Settings keys, visibility conditions, default trigger selector, drupalSettings** →
  [configure/settings.md](configure/settings.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Assets attach in `hook_page_attachments` only if the user has `use page load progress` AND the
  current path passes `evaluate_visibility_conditions()` (Views admin paths always excluded).
- `template_preprocess_input()` adds class `page-load-progress-submit` to non-AJAX submit buttons;
  the JS locks the screen when a form containing a matching element is submitted (after `delay` ms).
- Config → browser as `drupalSettings.page_load_progress` (`delay`, `elements`, `internal_links`,
  `esc_key`).
