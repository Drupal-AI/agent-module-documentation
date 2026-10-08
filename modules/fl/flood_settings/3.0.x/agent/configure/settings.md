# Configure — flood settings form

Route `flood_settings.settings` → `/admin/config/system/flood`
(`Drupal\flood_settings\Form\FloodSettings`, a `ConfigFormBase`).
Access: permission **`manage flood settings`** (title "Manage flood settings"; not
`restrict access: true`, so it is grantable to non-admin roles).

## What it edits

The form's only editable config object is core's **`user.flood`**. On submit it writes
exactly these five keys with `configFactory->getEditable('user.flood')`:

| Key | Field | Widget | Meaning |
|---|---|---|---|
| `uid_only` | Username only | checkbox | Track flood per account only, ignoring IP (strictest). |
| `ip_limit` | Failed login (IP) limit | select | Max failed logins per IP before block. Options: 1–500. |
| `ip_window` | Failed login (IP) window | select | Seconds the IP count is measured over. `0` = None (disabled). |
| `user_limit` | Failed login (username) limit | select | Max failed logins per account before block. Options: 1–500. |
| `user_window` | Failed login (username) window | select | Seconds the per-user count is measured over. `0` = None (disabled). |

Window options are human interval labels built from these seconds: 60, 180, 300, 600, 900,
1800, 2700, 3600, 10800, 21600, 32400, 43200, 86400 (plus `0` = "None (disabled)").
Occurrence options: 1–10, 20, 30, 40, 50, 75, 100, 125, 150, 200, 250, 500.

Code defaults used as form fallbacks when a key is unset: `ip_limit` 50, `ip_window` 3600,
`user_limit` 5, `user_window` 21600. These are the module's own constants, not written to
config until you save.

These are the same keys Drupal core's user-login flood checks read
(`user_failed_login_ip` / `user_failed_login_user`), so changes apply immediately.

## Equivalent without the UI

```bash
ddev drush config:set user.flood ip_limit 100 -y
ddev drush config:set user.flood user_window 3600 -y
ddev drush config:get user.flood        # review current values
```

Setting a window to `0` disables that flood dimension. `uid_only: true` makes lockouts
account-based regardless of source IP.
