<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toastr (toastr) — agent index

Integrates the **toastr.js** JavaScript library so Drupal's status/warning/error
messages render as transient "toast" popups instead of in the page's status-messages
region. Two hooks do the work: `hook_page_attachments` attaches the JS on every page,
and `hook_js_settings_alter` pulls the pending messages out of the Messenger
(`deleteAll()`) and hands them to the browser via `drupalSettings.toastr`. A JS
behavior (`Drupal.behaviors.toastrMessages` in `js/messages.js`) then calls
`toastr[type](message)` for each one.

- Dependencies: core only (`core/jquery`, `core/drupalSettings`). No module deps.
- Core requirement: `^9 || ^10 || ^11`.
- Configure route: `toastr.settings` → `/admin/config/system/toastr` (permission `administer toastr`).
- Provides: 1 permission, a config object with schema. No drush, no services, no plugins.
- The toastr.js library itself is loaded from a **CDN** (cdnjs), not bundled — see theme doc.

Solution docs:
- **Change position, timeouts, easing and behaviour** → [configure/settings.md](configure/settings.md)
- **Gate the settings page** → [permissions/permissions.md](permissions/permissions.md)
- **Understand the library integration and how a message becomes a toast** → [theme/messages.md](theme/messages.md)

Key facts:
- Config object: `toastr.settings` (16 keys, all `toastr_*`; defaults also live in
  `ToastrSettingsForm::defaultSettings()`).
- Route: `toastr.settings`; form: `\Drupal\toastr\Form\ToastrSettingsForm` (id `toastr_settings`).
- Permission: `administer toastr`.
- Libraries: `toastr/core` (the toastr.js CDN asset + jQuery) and `toastr/messages` (js/messages.js).
- Hooks: `toastr_page_attachments()`, `toastr_js_settings_alter()` in `toastr.module`.
- drupalSettings contract: `drupalSettings.toastr.messages` (keyed by type) and
  `drupalSettings.toastr.settings` (the `toastr_*` values).
