<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emergency Notification (emergency_notification) — agent index

A site-wide **emergency alert banner**: one admin-authored, dismissible popup injected into the top
of every page (minus excluded paths). Package none; core-only (`^10 || ^11`); GPL-2.0-or-later;
version-dir 2.1.x (installed 2.1.0). No entities, no external delivery (no email/SMS/push), no
Drush, no plugin types.

- **The settings form, the config object + schema, permission, route/menu link, the page_top
  render + JS/CSS behavior** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One hook, `emergency_notification_page_top()` (`emergency_notification.module`), renders the
  `emergency_notification` theme (template `templates/emergency-notification.html.twig`) into
  `$page_top` when `popup_enabled` is set and the current path/alias is not matched by
  `exclude_paths` (matched via `path.matcher` against both `path.current` and the alias). Notice
  body is passed through `check_markup($value, $format)`; title and button text are plain config
  strings (Twig-autoescaped).
- `emergency_notification_theme()` declares themes `emergency_notification` and
  `emergency_notification_icon`.
- `emergency_notification_page_attachments_alter()` adds an inline `<style>` to `html_head` (only
  when `enable_colors` is on) built by the service.
- `emergency_notification_help()` renders `README.md` on the module help page (via the `markdown`
  filter plugin if the Markdown module is present, else `<pre>`).

## Service / form / config

- Service **`emergency_notification.manager`** → `EmergencyNotificationManager`
  (`src/EmergencyNotificationManager.php`), arg `@config.factory`. `getConfig()` returns the
  immutable `emergency_notification.settings`; `getCss()` → `buildConfigCss()` composes a CSS string
  from `overlay_color` / `background_color` / `foreground_color`.
- Form **`EmergencyNotificationConfigurationForm`** (`src/Form/…`, a `ConfigFormBase`, form id
  `emergency_notification_admin_settings`), editing config `emergency_notification.settings`.
  `submitForm()` writes all fields, sets a fresh `form_submission_uuid` (via `@uuid`), and calls
  `drupal_flush_all_caches()`.
- Route **`emergency_notification.admin_settings`** — `/admin/config/system/emergency-notification`,
  `_permission: "emergency notification settings"` (declared in `.permissions.yml`); menu link under
  `system.admin_config_system`. `configure` points here.

## Front-end

- Library `emergency_notification/emergency_notification` (`css/emergency-notification.styles.css`,
  `js/emergency-notification.js`; deps `core/drupal`, `core/drupalSettings`, `core/js-cookie`).
- `Drupal.behaviors.emergencyNotification` reads `drupalSettings.emergencyNotificationSettings`
  (`formSubmission` UUID + `enableNotification`), sets `emergency_notification_id` /
  `emergency_notification_dismiss` cookies, and toggles the popup open/dismissed. A new
  `form_submission_uuid` on save invalidates the dismissal cookie, re-showing the notice.

## Config keys (`emergency_notification.settings`)

`popup_enabled` (bool), `notice_title` (string), `notice_text` ({value, format}; default format
`full_html`), `open_button_text`, `enable_colors` (bool), `overlay_color` / `background_color` /
`foreground_color` (hex, core Color element = server-validated), `exclude_paths` (newline patterns,
default `/admin/*`), `form_submission_uuid` (set on save). Only `open_button_text` and
`exclude_paths` are covered by `config/schema/emergency_notification.schema.yml`. Full detail in
[config/settings.md](config/settings.md).
