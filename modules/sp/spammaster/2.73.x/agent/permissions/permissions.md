# Spam Master — permissions & route access

## Defined permission

| Permission | `restrict access` | Notes |
|---|---|---|
| `manage spam master` | `TRUE` | Declared in `spammaster.permissions.yml`. NOTE: the admin routes do **not** actually require it — every settings form uses the core `administer site configuration` permission instead. This permission appears vestigial in this release. |

## Route access summary

| Route | Access requirement |
|---|---|
| `spammaster.settings` + `…_protection` / `…_buffer` / `…_white` / `…_log` | `administer site configuration` (core, `restrict access: TRUE`). |
| `spammaster.spammasterfirewall` (`/firewall`) | `access content` (public block page). |
| `spammaster.spammasteraction` (`/spam-master/v1`) | `access content`, but the controller further requires a POST body carrying the site's `license_key` and `db_protection_hash`; without both it returns 401. |

Grant `administer site configuration` only to trusted admins (it also governs entering/reading the
Spam Master license key and toggling enforcement).
