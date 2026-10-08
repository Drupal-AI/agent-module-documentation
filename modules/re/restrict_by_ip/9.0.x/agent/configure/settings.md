# Configure Restrict By IP

Admin UI under `/admin/config/people/restrict_by_ip` (overview controller), with sub-forms:

| Route | Path | Sets |
|---|---|---|
| `restrict_by_ip.general_settings` | `/admin/config/people/restrict_by_ip` | Overview + detected IP. |
| `restrict_by_ip.login_settings` | `.../login` | Global login ranges, error page, denied message. |
| `restrict_by_ip.user_settings` | `.../login/user` | (Per-user helper.) |
| `restrict_by_ip.role_settings` | `.../role` | Per-role ranges, role-removed message. |

All require the permission **`administer restrict by ip`** (`restrict access: true`).

## Config object `restrict_by_ip.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `login_range` | sequence of CIDR strings | `{}` (empty) | Global login allow list. Empty = no global restriction. |
| `role` | map `role_id → sequence of CIDR` | `{}` | Per-role allow lists. A role listed here is removed on requests whose IP is outside its ranges. |
| `error_page` | string (internal path) | `''` | Where a denied/logged-out user is redirected. Empty → the login page. |
| `login_denied_message` | label | "Your IP address is not permitted to sign in to this site." | Shown on login denial / forced logout. |
| `role_ip_behavior` | string | `remove` | Behaviour when a user is outside a role's range. |
| `role_removed_message` | label | "A change to your IP address has changed your access level…" | Shown when a role is stripped. |

CIDR entry format: one range per line (user field) or per the form; e.g. `10.20.30.0/24`,
`203.0.113.5/32`, IPv6 supported. A `/0` prefix (`0.0.0.0/0`) means "any address".

Edit global ranges from Drush (config or the convenience command in
[../drush/commands.md](../drush/commands.md)):

```bash
drush config:set --input-format=yaml restrict_by_ip.settings login_range '["203.0.113.5/32"]'
# Clear (lift) the restriction — note '{}' not '[]':
drush config:set --input-format=yaml restrict_by_ip.settings login_range '{}'
```

## Per-user allowed ranges

A base field **`restrict_by_ip_ranges`** (string_long, one CIDR per line) is added to every user
(`src/Hook/RestrictByIpHooks.php`). It appears in a "Restrict by IP" area on the user add/edit form.
`hook_entity_field_access` forbids viewing/editing it unless the actor has `administer restrict by ip`, so
ordinary users cannot see or change their own IP restriction. A `RestrictByIpCidrList` validation
constraint rejects malformed input.

## How the login decision works (`LoginFirewall::isLoginAllowed`)

- Global list matches the IP → **allow**.
- Else user list matches → **allow**.
- Else if BOTH lists are empty/unconfigured → **allow**.
- Otherwise → **deny** (a configured list that does not match denies).

Denial paths: inline login-form error (`validateIpRestriction`) so no session is created; and, for an
already-authenticated request, `FirewallSubscriber` clears/destroys the session and redirects.

## Per-role decision (`RoleFirewall::rolesToRemove`)

On every request, for each real role with configured ranges, if the request IP is outside all of them the
role is removed for that request (`RoleRestrictionSubscriber`). `authenticated` and `anonymous` are never
restricted (removing `authenticated` would break the session).

## IP detection / reverse proxies

The client IP is `Request::getClientIp()` (`src/IPTools.php::getUserIP`). This returns the real connecting
socket IP and only honours `X-Forwarded-For` when the request comes from a **trusted proxy configured in
Drupal** (`$settings['reverse_proxy']` / `reverse_proxy_addresses` in `settings.php`). Configure those
correctly behind a load balancer, otherwise all requests appear to come from the proxy IP. A spoofed
`X-Forwarded-For` from an untrusted client is ignored.
