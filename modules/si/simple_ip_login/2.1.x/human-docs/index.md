# Simple IP Login — manual setup guide

**Simple IP Login** (`simple_ip_login`) logs a user in automatically when their
client IP address matches a rule you configure. You define **IP Wildcard** entities
that map an IP pattern (a regular expression, such as `/127\.0\.0\.0/` for
localhost, or a pattern matching `192.*.*.*`) to a specific user account; when a
visitor arrives from a matching IP, the module establishes a full authenticated
session for the mapped account — no password required. It is a trusted‑network /
kiosk convenience: think of a lobby kiosk that should always be signed in as a
display account, or a controlled office network where a device logs in
automatically.

Because it grants a real session based purely on source IP, **security is the
central consideration here**, and it is the site owner who owns that risk:

- **It grants a full session by source IP.** Use it only for genuinely trusted,
  controlled networks.
- **Shared IPs are dangerous.** On NAT, CGNAT, office, or VPN networks many people
  share one public IP — and everyone from that IP would be logged in as the mapped
  account. Never map an IP shared by untrusted users, and never map a high‑privilege
  (e.g. administrator) account on a shared network.
- **It relies on correct reverse‑proxy configuration.** The module reads the client
  IP via `$request->getClientIp()`, which honours Drupal's trusted‑proxy settings and
  does **not** blindly trust the `X-Forwarded-For` header. But if your site sits
  behind a proxy or CDN and `settings.php` is misconfigured to trust all proxies, an
  attacker could spoof `X-Forwarded-For` and impersonate any mapped user. Configure
  `reverse_proxy` / `trusted_hosts` correctly **before** relying on this module.

Within those constraints it is a legitimate convenience; outside them it is an
authentication‑bypass foot‑gun. The module depends only on Drupal core and provides
its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define IP Wildcard rules that map IP
   patterns to accounts, with the safety rules to follow.

## Where it lives in the admin menu

The IP Wildcard rules are managed at the module's configure route,
`entity.ip_wildcard.collection`. The module's own documentation points you to
**Configuration → System → Simple IP Login**.
