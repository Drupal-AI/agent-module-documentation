# Configuration

## Open the settings form

1. Grant the **Manage flood settings** permission to the roles that should manage
   login limits (at **People → Permissions**). This permission is *not* marked
   "restricted", so you can hand it to a non‑admin role.
2. Go to **Configuration → System → Flood settings**, or navigate directly to
   `/admin/config/system/flood`.

The form edits core's **`user.flood`** configuration object directly — the same
values Drupal's login flood checks read — so your changes apply immediately.

## The fields

| Field | What it controls |
|---|---|
| **Username only** | A checkbox. When ticked, flood lockouts are tracked **per account only**, ignoring the source IP. This is the strictest option. |
| **Failed login (IP) limit** | How many failed logins are allowed from a single IP address before that IP is temporarily blocked. Chosen from a list (1–500). |
| **Failed login (IP) window** | The time window over which those per‑IP attempts are counted, as a human interval (1 minute up to 1 day). Choose **None (disabled)** to turn the per‑IP limit off. |
| **Failed login (username) limit** | How many failed logins are allowed against a single username before that account is temporarily blocked. Chosen from a list (1–500). |
| **Failed login (username) window** | The time window for the per‑username count, as a human interval. Choose **None (disabled)** to turn the per‑username limit off. |

The window options correspond to these interval choices: 1, 3, 5, 10, 15, 30, 45
minutes, and 1, 3, 6, 9, 12, and 24 hours (plus "None (disabled)"). The attempt
options run 1–10 and then 20, 30, 40, 50, 75, 100, 125, 150, 200, 250, 500.

If a value has never been set, the form falls back to sensible defaults — IP
limit 50 over 1 hour, username limit 5 over 6 hours — but these are only written
to config once you save.

## Practical tips

- **Under a brute‑force / credential‑stuffing attack**, tighten the limits —
  lower the IP limit, or enable **Username only** to lock accounts regardless of
  the attacker's rotating IPs.
- **During a legitimate traffic spike or a load test**, loosen the limits
  temporarily so real users aren't caught out.
- **Recovering from accidental lockouts** — widen the limits here, then flush the
  existing flood entries so blocked users can log in again.
- Selecting **None (disabled)** for a window turns that flood dimension off
  entirely; use with care on public‑facing sites.

## Doing the same thing without the UI

The form just writes core config, so the equivalent on the command line is:

```bash
ddev drush config:set user.flood ip_limit 100 -y
ddev drush config:set user.flood user_window 3600 -y
ddev drush config:get user.flood        # review current values
```
