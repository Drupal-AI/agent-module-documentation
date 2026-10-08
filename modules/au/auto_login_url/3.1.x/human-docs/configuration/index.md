# Configuration

## Open the settings form

1. Log in as a user with the **Administer auto login url** permission.
2. Go to **People → Auto Login URL**, or navigate directly to
   `/admin/people/autologinurl`.

The settings form controls the security and lifetime defaults for every link you
mint. (Individual links can override some of these when created in code.)

## Settings, field by field

- **Secret** — the HMAC secret that, together with your site's hash salt and each
  user's password hash, makes the tokens unforgeable. It is generated
  automatically on first use, so you normally leave it alone. Two deliberate uses:
  **regenerate** it to instantly invalidate *every* outstanding link on the site,
  or blank it to force a fresh one.
- **Expiration** — the default lifetime of a link, in seconds. Default `2592000`
  (30 days). Shorten this for sensitive flows; individual links can pass a custom
  expiration.
- **Single-use (delete after login)** — when on, a link is deleted the first time
  it successfully logs someone in. Off by default globally; code that mints a link
  can force single-use per link regardless.
- **Token length** — how many characters of the HMAC form the URL token
  (8–128, default 64). Longer is stronger; 64 is a sensible default.
- **Validate IP address** — when on, a link only works from the same IP address
  that created it. Useful for higher-security, same-session flows; leave off for
  ordinary email links (recipients rarely share the creator's IP).
- **Enable usage analytics** — logs each use into an analytics table (pruned to
  the last six months by cron). Powers the **Usage** report.
- **Max URLs per user per hour** — a per-user creation rate limit (default 10) to
  curb abuse when links are minted programmatically.

Click **Save configuration** to apply.

### Setting values from the command line

```bash
ddev drush config:set auto_login_url.settings expiration 3600 -y            # 1-hour default
ddev drush config:set auto_login_url.settings delete 1 -y                   # global single-use
ddev drush config:set auto_login_url.settings validate_ip_address 1 -y      # lock links to creator IP
```

## Admin and reporting pages

All of these require the **Administer auto login url** permission:

| Page | Path | What it does |
|------|------|--------------|
| Settings | `/admin/people/autologinurl` | This form. |
| Generate | `/admin/people/autologinurl/generate` | Mint a login link for a chosen user from the UI. |
| Manage | `/admin/people/autologinurl/manage` | List existing links. |
| View | `/admin/people/autologinurl/view/{id}` | Inspect a single link. |
| Delete | `/admin/people/autologinurl/delete/{id}` | Delete one link. |
| Bulk delete | `/admin/people/autologinurl/bulk-delete` | Remove expired links in bulk. |
| Usage | `/admin/people/autologinurl/usage` | Usage analytics. |
| Health check | `/admin/reports/auto-login-url/health` | Operational health endpoint for monitoring. |

## Permissions

Both permissions are marked **security-restricted** — grant them with care at
**People → Permissions**:

- **Administer auto login url** — full access to the settings and all the
  management/reporting pages. A holder can mint a login link for **any** user,
  including user 1 (the superuser). Treat as trusted-admin only.
- **Use auto login url** — described as "authenticate using auto login URLs". Note
  that in this version the public login route does **not** actually gate on this
  permission — a valid token is what logs the user in — so the permission is
  effectively advisory.

## Security defaults worth reviewing

- The public login URL is meant to be hit unauthenticated: **the token is the
  credential.** Always send links over HTTPS and treat them like passwords.
- A user's outstanding links are automatically invalidated when their password
  changes (the password hash is part of the token key).
- Login attempts are flood-protected per IP using core's `user.flood` limits;
  failures are logged.
- For sensitive flows, combine a short **expiration**, **single-use**, and
  optionally **Validate IP address**.
