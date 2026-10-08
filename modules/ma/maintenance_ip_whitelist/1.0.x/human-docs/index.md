# Maintenance IP Whitelist — manual setup guide

**Maintenance IP Whitelist** (`maintenance_ip_whitelist`) lets a list of IP
addresses continue browsing your site while it is in maintenance mode — even as
**anonymous** visitors, without any user account and without the core *access
site in maintenance mode* permission. It's the practical way to let a client, a
QA team, or your office network preview a site during a maintenance window while
everyone else still sees the maintenance page.

This is especially handy when you need to test workflows built for anonymous
users, which you can't do if the only way through maintenance mode is to log in
as a privileged user.

Under the hood, the module decorates Drupal's core maintenance-mode service: when
a visitor's IP is on your allowlist, they are treated as exempt from maintenance
mode; otherwise they see the normal maintenance page. There's no new admin page —
the allowlist is a textarea added straight onto the core maintenance settings
form.

A note on how the IP is determined, because it matters for security: the module
reads the visitor's IP from the **actual TCP connection** (`REMOTE_ADDR`), *not*
from a client-supplied header like `X-Forwarded-For`. That means the allowlist
**cannot be spoofed** by a visitor faking a header — the safe choice. The
trade-off is that if your site sits **behind a reverse proxy, load balancer, or
CDN**, `REMOTE_ADDR` will be the *proxy's* IP, not the end user's. In that setup
you must configure Drupal's trusted-proxy / reverse-proxy settings (in
`settings.php`) correctly, and whitelist the IPs your application actually sees,
or the check won't match your real visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — add your allowed IP addresses on
   the core maintenance form.

## Where it lives in the admin menu

The module adds its allowlist field to core's maintenance settings at
**Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).
