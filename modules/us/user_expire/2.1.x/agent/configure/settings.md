<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure User Expire

Admin UI: `/admin/config/people/user-expire` (route `user_expire.admin`, form
`UserExpireSettingsForm`, requires `administer user expire settings`). Everything persists in
the config object `user_expire.settings`.

## Config keys (`user_expire.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `user_expire_roles` | sequence `role_id => int` | `{}` | Seconds of **inactivity** after which accounts holding each role are blocked. `0` (or absent) = never expire for that role. e.g. `7776000` = 90 days. |
| `send_expiration_warnings` | boolean | `true` | Master switch for warning emails. |
| `frequency` | integer (seconds) | `172800` (2 days) | Minimum interval between warning-email runs (throttle; tracked via State key `user_expire_last_run`). |
| `offset` | integer (seconds) | `604800` (7 days) | How far **before** expiry to start warning users. |
| `expiration_warning_mail.subject` | string | `[site:name]: Account expiration warning` | Warning email subject (tokens allowed). |
| `expiration_warning_mail.body` | text | (default template) | Warning email body (tokens allowed, e.g. `[user:display-name]`, `[site:login-url]`). |

Note: per-role values in `user_expire_roles` are keyed by **role machine name**; the special
`authenticated` role applies to all logged-in users (it is handled without a role-table join).

## Set it with drush

```bash
# Expire authenticated users after 90 days of inactivity
drush php:eval '$c=\Drupal::configFactory()->getEditable("user_expire.settings");
  $r=$c->get("user_expire_roles"); $r["authenticated"]=7776000; $c->set("user_expire_roles",$r)->save();'

# Turn warning emails off
drush config:set user_expire.settings send_expiration_warnings 0 -y

# Start warning 14 days out, repeat daily
drush config:set user_expire.settings offset 1209600 -y
drush config:set user_expire.settings frequency 86400 -y

# Read the role rules
drush config:get user_expire.settings user_expire_roles
```

The settings form renders one numeric "seconds of inactivity" field per existing role, plus a
"Time reference table" (days → seconds) to help pick values, and validates each value as an
integer ≥ 0 (schema `Range` constraint).

## Permissions (`user_expire.permissions.yml`, all `restrict access: true`)

| Permission | Gates |
|---|---|
| `set user expiration` | The "User expiration" details section on the **user edit form** (tick + pick a date for a single account). |
| `view expiring users report` | The Expiring users report at `/admin/reports/expiring-users`. |
| `administer user expire settings` | The settings form above. |

## Per-user expiration (not config)

A single account's expiration date is **not** stored in config — it lives in the `user_expire`
DB table. See [../api/mechanics.md](../api/mechanics.md).
