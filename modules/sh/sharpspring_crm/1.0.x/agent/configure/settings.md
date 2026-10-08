<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring SharpSpring CRM

Route `sharpspring_crm.admin_settings_form` → `/admin/config/sharpspring_crm/settings`, permission `administer sharpspring settings`. Config object `sharpspring_crm.settings`:
- `account_id` — SharpSpring account ID.
- `secret_key` — SharpSpring API secret key (stored in plain config).
- `backupEmailAddress` — address emailed when a lead fails to reach SharpSpring.

API base (SharpSpringCrm.php): `http://api.sharpspring.com/pubapi/v1/?accountID=…&secretKey=…` — **plain HTTP**, credentials in the query string. If you must run this, front it with an HTTPS-terminating egress proxy and treat the secret as exposed on the wire.
