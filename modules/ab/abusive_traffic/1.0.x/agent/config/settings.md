<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object & secrets

## Install / enable

`drush en abusive_traffic`. No module dependencies are declared. Practical requirements: **Acquia
Cloud Next hosting** (the commands call the Acquia Cloud API and read Acquia secrets) and the
**phpseclib** library for SFTP forwarding — `composer require phpseclib/phpseclib:~3.0`. There is
no `config/install`, so the `abusive_traffic.settings` object is created on first save of the form.

## Route & access

- Route `abusive_traffic.settings` → `/admin/config/system/abusive-traffic`
  (`abusive_traffic.routing.yml`), form `Drupal\abusive_traffic\Form\AbusiveTrafficSettingsForm`.
- Requirement: `_permission: 'administer site configuration'` — admin-only. Menu link
  `abusive_traffic.settings` under parent `system.admin_config_system`
  (`abusive_traffic.links.menu.yml`).

## Config object `abusive_traffic.settings`

Written by `AbusiveTrafficSettingsForm::submitForm()`; there is **no config schema** shipped.

| Key | Widget | Default | Meaning |
|---|---|---|---|
| `threshold` | textfield | 100 | An IP at/over this hit count triggers an alert email. |
| `ignorelist` | textarea | — | IPs to exclude, one per line; `*` wildcard allowed (e.g. `127.0.0.*`). |
| `emaillist` | textarea | — | Comma-separated recipient addresses for alerts. |
| `forward_log_files` | checkbox | — | If on, `get-log` also uploads each log over SFTP. |

`validateForm()` rejects a `threshold` that is non-numeric or `< 1` (error attached to field
`message`).

## Secrets (read via config factory, not module config)

`buildForm()` and the Drush commands read these Acquia-secrets config objects with `->get('key')`
and show a red error message on the form for any that are missing:

- `abusive_traffic_acquia_client_id` — Acquia Cloud API client id.
- `abusive_traffic_acquia_client_secret` — Acquia Cloud API client secret.
- `abusive_traffic_acquia_application_uuid` — target application UUID (get it from
  `drush abusive_traffic:list-applications`).
- When `forward_log_files` is on: `abusive_traffic_sftp_username`, `abusive_traffic_sftp_password`,
  `abusive_traffic_sftp_server`, `abusive_traffic_sftp_path` (path may be `''` for the server root).

These are populated through the Acquia secrets mechanism (secrets.settings.php), not through
Drupal's admin UI. The form only *reports* whether each is present; it never sets them.

## Operating it

Set the threshold high (100) at first, review alerts, then tune. Add already-blocked / known-good
IPs to the ignore list to cut noise. The module only identifies IPs — blocking is a separate step
(core Ban module at `/admin/config/people/ban`, or a `.htaccess`/firewall rule). See
[../api/drush-commands.md](../api/drush-commands.md) for the cron commands that actually produce
the alerts.
