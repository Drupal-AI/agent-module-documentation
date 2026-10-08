<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emergency Notification — settings, rendering, and front-end

How the single site-wide alert is configured, composed, and shown. Everything lives in one config
object; there is no external delivery channel (no email/SMS/push) and no entities.

## Install / enable

Core-only (`core_version_requirement: ^10 || ^11`). `drush en emergency_notification -y`. Config at
**Configuration > System > Emergency Notification settings**
(`/admin/config/system/emergency-notification`; `configure` in `.info.yml` and the menu link
`emergency_notification.admin_settings` under `system.admin_config_system`).

## Permission & route

- Permission **`emergency notification settings`** (`emergency_notification.permissions.yml`,
  label "Emergency notification settings") — grants access to the settings form.
- Route `emergency_notification.admin_settings` (`emergency_notification.routing.yml`):
  `_form: EmergencyNotificationConfigurationForm`, `_permission: "emergency notification settings"`.
  The form is a `ConfigFormBase` (POST), so state changes go through the standard form pipeline.

## Config object `emergency_notification.settings`

Defaults from `config/install/emergency_notification.settings.yml`:

- `popup_enabled` (bool, `false`) — master on/off. Checked in `emergency_notification_page_top()`.
- `notice_title` (string, `''`) — plain textfield; rendered as Twig `{{ title }}` (autoescaped).
- `notice_text` (`{value, format}`, format default `full_html`) — a `text_format` element; rendered
  via `check_markup($value, $format)` so the chosen text format's filters apply.
- `open_button_text` (string, default `Display alert`) — label of the reopen button.
- `enable_colors` (bool, `false`) — when on, the three color fields are used and an inline `<style>`
  is emitted.
- `overlay_color` (`#1d1d1d`), `background_color` (`#ff3535`), `foreground_color` (`#ffffff`) —
  `#type => color` fields (`#required`), so core's Color element validates them to hex server-side;
  shown only when `enable_colors` is checked (`#states`).
- `exclude_paths` (text, default `/admin/*`) — newline-separated path patterns; `*` wildcard.
- `form_submission_uuid` — not a form field; `submitForm()` sets a fresh UUID (`@uuid`) on every
  save so previously dismissed clients see the notice again.

Schema (`config/schema/emergency_notification.schema.yml`) is partial: it types only
`open_button_text` and `exclude_paths`. The boolean/color/`notice_text` keys are not described in
schema.

## The form — `EmergencyNotificationConfigurationForm`

`src/Form/EmergencyNotificationConfigurationForm.php`, form id `emergency_notification_admin_settings`,
`getEditableConfigNames()` = `['emergency_notification.settings']`. Constructor injects
`config.factory`, `config.typed`, and `uuid`. `buildForm()` renders the fields above (colors gated by
`#states` on `enable_colors`). `submitForm()` writes every value, sets
`form_submission_uuid = $this->uuid->generate()`, `save()`s, then calls
`drupal_flush_all_caches()` (a full cache flush on each save).

## Rendering — `emergency_notification.module`

- `emergency_notification_page_top(&$page_top)`: loads `emergency_notification.settings`, computes
  the current path (`path.current`) and its alias (`path_alias.manager`), and tests both against
  `exclude_paths` with `path.matcher`. If `popup_enabled != 0` and neither path is excluded, it adds
  a render element:
  - `#theme => 'emergency_notification'` with `#title`, `#notice_text` = `check_markup(value, format)`,
    `#open_button_text`, `#dismiss_button_text` = `t('Dismiss')`, and an `#icon`
    (`#theme => 'emergency_notification_icon'`, SVG `use` of `images/icon.svg`).
  - `#attached.drupalSettings.emergencyNotificationSettings` = `{ formSubmission:
    form_submission_uuid, enableNotification: popup_enabled }`.
  - attaches library `emergency_notification/emergency_notification`.
- `emergency_notification_theme()`: themes `emergency_notification` (vars title, notice_text,
  open_button_text, icon, attributes) and `emergency_notification_icon` (vars url, id). Templates in
  `templates/`.
- `emergency_notification_page_attachments_alter(&$attachments)`: if `enable_colors`, appends an
  inline `<style>` (`#tag => 'style'`, `#value` = `EmergencyNotificationManager::getCss()`) to
  `html_head`.
- `emergency_notification_help()`: outputs `README.md` on the module's help page (rendered through
  the `markdown` filter plugin when the Markdown module is enabled, otherwise wrapped in `<pre>`).

## Service — `EmergencyNotificationManager`

`src/EmergencyNotificationManager.php` (service `emergency_notification.manager`, arg
`@config.factory`). `getConfig()` returns the immutable settings. `getCss()` → private
`buildConfigCss()` assembles a CSS string mapping the three configured colors onto fixed selectors
(overlay background, popup/button background, foreground text/link/heading colors).

## Front-end behavior

Library `emergency_notification/emergency_notification`: `css/emergency-notification.styles.css`,
`js/emergency-notification.js`; deps `core/drupal`, `core/drupalSettings`, `core/js-cookie`.
`Drupal.behaviors.emergencyNotification` (runs once) reads
`settings.emergencyNotificationSettings`; when `enableNotification` is truthy it: (1) `setCookies()`
— if the `formSubmission` UUID differs from cookie `emergency_notification_id`, resets
`emergency_notification_dismiss` to 0 and stores the new id; (2) `togglePopup()` opens the popup if
not yet dismissed and wires the reopen button to a slide toggle; (3) `dismissPopup()` wires the
dismiss button to hide the popup and set `emergency_notification_dismiss = 1`. Net effect: a visitor
dismisses the current alert once; re-saving the form (new UUID) re-shows it.

## Templates

- `templates/emergency-notification.html.twig` — wrapper `#emergency-notification`, popup
  `<article class="emergency-popup">` with `{{ icon }}`, `{{ title }}`, `{{ notice_text }}`, a
  Close/Dismiss button, and a fixed reopen button carrying `{{ open_button_text }}`.
- `templates/emergency-notification-icon.html.twig` — inline SVG referencing `images/icon.svg`.
