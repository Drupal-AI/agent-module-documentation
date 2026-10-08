# Spambot permissions

Spambot defines exactly **one** permission (`spambot.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `protected from spambot scans` | `TRUE` | A user/role holding it **bypasses all spambot checks**: the registration validator is not added (`spambot_add_form_protection()` early-returns), and cron scans log but take **no** block/delete action against such accounts (`spambot_cron` forces `SPAMBOT_ACTION_NONE`). |

Notes:
- `restrict access: TRUE` marks it as security-sensitive in the permissions UI.
- Access to the settings form is gated by core `administer site configuration`, and the per-user
  **Spam** tab route (`spambot.user_spam`, `/user/{user}/spambot`) by core `administer users` — not by
  a spambot-specific permission.
- Grant `protected from spambot scans` only to trusted roles (e.g. staff), since it fully disables
  spam filtering for those users.
