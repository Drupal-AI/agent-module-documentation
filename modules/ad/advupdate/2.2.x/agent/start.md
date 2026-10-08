<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Manager Advanced (advupdate) — agent index

Expands core's "Available updates" notification email with full per-project update detail
(installed vs recommended + release-note links), and adds a "Security Updates" admin block.
No own permissions, no Drush. Config lives on core's Update settings form
(`configure: update.settings`). Depends on core `update` + `block`; core `^11.3`.

- **The `notification.extend_email_report` setting, the email alteration, the Security Updates
  block placement & access** → [configure/settings.md](configure/settings.md)

Key facts:
- `hook_mail_alter()` appends detail to the `update_status_notify` email when
  `advupdate.settings:notification.extend_email_report` is on (**default: true**, in
  `config/install/advupdate.settings.yml`).
- Email markup: `src/Render/UpdateDetailsMarkup::createFromProjectData()` from core
  `update_get_available()` / `update_calculate_project_data()`; groups Enabled / Disabled /
  Manual(core); the class's `create()` is disabled (returns "Not permitted.") so only update
  data is rendered.
- Setting checkbox added to `update.settings` form via `hook_form_update_settings_alter()`
  (`/admin/reports/updates/settings`).
- Block plugin `advupdate_security_updates` (`src/Plugin/Block/SecurityUpdatesBlock.php`):
  lists `NOT_SECURE` projects; `blockAccess()` requires `administer site configuration` and
  hides when no security updates exist.
