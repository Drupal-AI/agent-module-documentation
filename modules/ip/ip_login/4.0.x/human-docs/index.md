# IP Login — manual setup guide

**IP Login** (`ip_login`) automatically logs a user in when their **client IP
address** matches an address, range, or wildcard configured on that user's
account — no username or password required. It's designed for genuinely trusted
setups: a kiosk that should always be signed in as one account, a single‑tenant
office where a fixed public IP belongs to one person, or a controlled device on a
known network.

The IP ranges are stored per user via the **Field IP address**
(`field_ipaddress`) module. An early HTTP middleware checks the visitor's IP
*before* the page cache; if it matches an active user's configured range, the
module establishes a full authenticated session for that account. It supports
single IPs, ranges (`123.4.5.6-10`), and wildcards (`123.4.5.*`), can be limited
to specific paths, and has a permission that lets a matched user choose to log in
as someone else instead.

> ## ⚠️ Security: read this before enabling
>
> **IP Login grants a full authenticated session based solely on the source IP.**
> That makes it powerful and, if misused, an authentication‑bypass foot‑gun. Use
> it only on networks you genuinely control, and keep these rules in mind:
>
> - **Shared IPs are dangerous.** Behind NAT, CGNAT, an office gateway, or a VPN,
>   many people share one public IP — and *every one of them* would be logged in
>   as the single mapped account. Map an IP only when it truly corresponds to one
>   trusted person or an intentionally shared kiosk.
> - **Never map high‑privilege accounts on shared networks.** Auto‑logging into an
>   admin account by IP turns anyone who can reach that network path into an admin.
> - **It depends on correct reverse‑proxy configuration.** The module reads the IP
>   with `getClientIp()`, which correctly honors Drupal's trusted‑proxy settings —
>   but if `settings.php` is misconfigured to trust all proxies or forwarded
>   headers from untrusted sources, an attacker can spoof `X-Forwarded-For` and
>   impersonate any mapped user. Configure `reverse_proxy` / `trusted_hosts`
>   correctly *before* relying on this module.
>
> The module's own code is careful (it uses the correct client‑IP API and only
> matches active users); the risk lives in how you deploy and configure it, and
> that responsibility is yours.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Field IP
   address dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — mapping IPs to users, path
   restrictions, permissions, and the trusted‑proxy prerequisites.

## Where it lives in the admin menu

IP Login's settings form is at **Site configuration → IP Login**
(route `ip_login.settings`), which also lists the IP‑enabled users. See
[Configuration](configuration/index.md).
