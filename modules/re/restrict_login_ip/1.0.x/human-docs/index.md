# Restrict Login Page by IP — manual setup guide

**Restrict Login Page by IP** (`restrict_login_ip`) locks the Drupal login page to an
administrator-defined allow-list of IP addresses and CIDR ranges. When you have set at
least one range, the `/user/login` page — including the REST login at
`/user/login?_format=json` — is reachable only from those addresses; every other IP
gets a `403`. The point is to take the login form off the open internet and expose it
only to trusted networks such as an office or a VPN, which sharply reduces the surface
for credential-stuffing and brute-force attempts coming from anywhere else.

Its access logic is sensible: when **no ranges are configured** the feature is off and
login is open to everyone (so installing the module changes nothing until you
configure it); if the request's client IP cannot be determined it **denies as a
precaution** (fail-closed); otherwise it allows only IPs that match the allow-list. It
uses Drupal's `getClientIp()`, which is the correct API — it honours your trusted-proxy
settings rather than blindly trusting the `X-Forwarded-For` header.

Two important cautions:

- **This restricts the login *page*, not every authentication route.** Other login
  methods — SSO, basic auth, and similar — are not blocked by it. In fact, if another
  authentication method such as basic auth is enabled, it can bypass the IP check
  entirely; the module even shows a warning on the status report in that case. Confirm
  every login entry point you care about is actually covered.
- **You can lock yourself out.** If you set ranges that do not include your own
  network, you will be locked out of the login page along with everyone else. Always
  keep a range that covers your own admin access, and know how to recover (see below).

One more prerequisite: because it reads the client IP, if your site sits behind a
proxy or CDN you must configure `reverse_proxy` and `trusted_host_patterns` in
`settings.php` correctly **first** — otherwise an attacker could spoof
`X-Forwarded-For` to look like an allowed IP and slip past the restriction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the allowed IPs/ranges (and the
   extended options), plus how to avoid and recover from a lockout.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Restrict Login Page by IP**
(`/admin/config/people/restrict_login_ip`). The allowed ranges can also be set
directly in `settings.php` as
`$config['restrict_login_ip.settings']['ip_ranges']`.
