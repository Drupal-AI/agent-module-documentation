# Configuration

All settings live under **Configuration → People → Restrict by IP**
(`/admin/config/people/restrict_by_ip`) and require the **Administer restrict by
IP** permission. The overview page also shows the IP address Drupal currently sees
for you — a useful sanity check before you lock anything down.

> **Enter ranges in CIDR notation, one per line.** For example `10.20.30.0/24`,
> a single host as `203.0.113.5/32`, or IPv6. A `/0` prefix (`0.0.0.0/0`) means
> "any address." A malformed range never matches, so a typo tightens access rather
> than loosening it.

## Global login restriction

On the **login** sub‑form (`.../login`) you set:

- **Global login ranges** (`login_range`) — the site‑wide allow‑list for logging
  in. **Empty means no global restriction.** Once you add any range, a login is
  only permitted from a matching IP (subject to the per‑user rule below).
- **Error page** (`error_page`) — an internal path a denied or forced‑out user is
  redirected to. Leave it empty to send them to the login page.
- **Login denied message** (`login_denied_message`) — the text shown on a denied
  login or forced logout. Defaults to *"Your IP address is not permitted to sign
  in to this site."*

### How the login decision is made

For a given login attempt the module decides in this order:

1. The **global** list matches the IP → **allow**.
2. Otherwise, the **user's own** list matches → **allow**.
3. Otherwise, if **both** lists are empty/unconfigured → **allow**.
4. Otherwise → **deny**.

In other words, a configured list that doesn't match denies, but a global list and
a user list are checked as alternatives — matching either one is enough.

## Per‑user restriction

Every user gets a **restrict_by_ip_ranges** base field (one CIDR per line) shown
in a "Restrict by IP" area on their add/edit form. Only actors with **Administer
restrict by IP** can see or change it — ordinary users cannot view or edit their
own IP restriction. Malformed entries are rejected by a validation constraint. Use
this to pin individual accounts (say, an admin) to a fixed address while leaving
everyone else unrestricted.

## Per‑role restriction

On the **role** sub‑form (`.../role`) you assign allowed ranges per role
(`role.<role_id>`) and set the **role removed message** (`role_removed_message`,
shown when a role is stripped). On **every request**, for each role that has
ranges configured, if the request IP is outside all of them that role is removed
for that request — so the user temporarily loses its permissions until they're
back on an allowed network.

Two roles are never restricted: **authenticated** and **anonymous** (removing
`authenticated` would break the session). The `role_ip_behavior` setting controls
what happens when a user is outside a role's range and defaults to `remove`.

## IP detection and reverse proxies

The client IP is the real connecting socket address. `X-Forwarded-For` is only
honored when the request comes from a **trusted proxy you've configured in
Drupal** (`$settings['reverse_proxy']` and `$settings['reverse_proxy_addresses']`
in `settings.php`). A spoofed `X-Forwarded-For` from an untrusted client is
ignored. Behind a load balancer you must set these, or every request will appear
to come from the proxy's IP and your ranges won't behave as expected.

## Drush commands

Two commands help you inspect restrictions and — importantly — recover from
lockouts. (A one‑time login link does **not** bypass the firewall.)

### `restrict_by_ip:status` (alias `rbi:status`)

Lists every configured range (global, all roles, and optionally a user's) and, if
you pass an IP, whether that IP matches each and whether a login would be allowed:

```bash
drush restrict_by_ip:status 203.0.113.5 --user=admin
```

Note it reflects config and field values only — ranges injected at runtime via the
alter hooks are not shown.

### `restrict_by_ip:allow` (alias `rbi:allow`)

Adds an allowed CIDR range to the global login list, or to one user's list:

```bash
# Allow logins from your current public IP site-wide:
drush restrict_by_ip:allow 203.0.113.5/32

# Allow it for one account only:
drush restrict_by_ip:allow 203.0.113.0/24 --user=admin
```

The range is validated (an invalid one errors out) and duplicates are skipped.

## Lockout recovery

If you've locked yourself out:

1. See what's blocking you:
   `drush restrict_by_ip:status <your_ip> --user=<you>`.
2. Either add your IP:
   `drush restrict_by_ip:allow <your_ip>/32` (add `--user=<you>` for a per‑user
   list), or clear the global list entirely:
   `drush config:set --input-format=yaml restrict_by_ip.settings login_range '{}'`
   (note `{}`, not `[]`).

## Supplying ranges at runtime (for developers)

Rather than storing ranges in config, other modules can add or remove them just
before enforcement via `hook_restrict_by_ip_ranges_alter()` and its
type‑specific variants (`login_global`, `login_user`, `role`). This is handy for
keeping office ranges in `settings.php` or pulling them from an external IP
database. Remember the semantics: a non‑empty list *introduces* a restriction, an
empty one lifts it. The `role` hook fires on every authenticated request, so keep
those implementations fast. Full details are in the
[`agent/`](../agent/start.md) docs.
