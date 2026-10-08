<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Experience for Reroute emails (reroute_email_be) — agent index

**Adds a permission-gated settings UI, governance roles, a status block and a test-mail form on top of the Reroute Email module.**

- **Version:** 1.0.x (1.0.0-rc2)
- **Core:** ^9 || ^10.3 || ^11
- **Requires:** reroute_email (>=2.3.0)
- **Configure route:** `reroute_email_be.settings` → `/admin/config/development/reroute_email_be` (`_permission: administer reroute email`)
- **Permissions:** `send rerouted email`, `edit destination address`, `edit allowed address`, `edit allowed roles`, `configure reroute email module`, `configure reroute email be module`
- **Roles installed:** data_owner, data_steward, data_custodian (config/install)
- **Block:** `rerouting_mail_status_block` (ReroutingStatus)
- **Form alter:** `reroute_email_be_form_reroute_email_settings_alter` disables fields per-permission
- **Drush:** `RerouteEmailCommands` (drush.services.yml)

**Security:** single admin settings route gated by `administer reroute email`; field access on the altered form is enforced per granular permission. No anonymous or mutating public endpoints.
