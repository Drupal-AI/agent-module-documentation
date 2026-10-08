# Trusted Reverse Proxy Support — manual setup guide

**Trusted Reverse Proxy Support** (`trusted_reverse_proxy`) helps sites that run
behind one or more trusted reverse proxies (Cloudflare, Varnish, a TLS
terminator, a load balancer, and so on) get the **real visitor IP address**
right — without you having to hardcode a list of proxy IPs in `settings.php`.

Normally, to make Drupal trust `X-Forwarded-For` headers you must set
`reverse_proxy` and enumerate every proxy's IP in `settings.php`. That's awkward
on cloud and container platforms where proxy IPs are dynamic or unknown ahead of
time. This module instead auto-detects the proxy chain from the incoming
`x-forwarded-for` header on each request and configures Drupal's reverse-proxy
settings at runtime — so the same codebase works locally (no proxy) and in
production (several proxies) with no settings changes. It also softens a related
status-report warning about missing `trusted_host_patterns` on proxied sites.

The module has **no admin page, no settings form, no permissions, and no Drush
commands** — enabling it is the "on" switch, and any tuning is done through
`settings.php`. It works the moment it's enabled and there is an `x-forwarded-for`
header on the request.

> **Read this before enabling.** This module is **opt-in and intended for sites
> behind upstream proxies you control.** See [Configuration](configuration/index.md)
> for how it decides what to trust and how to pin your proxy addresses instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how it decides what to trust, the
   `settings.php` overrides, the status-report tweak, and the recommended production setup.

## Where it lives in the admin menu

Nowhere — there is no configuration page. The only visible change is on the
**status report** at **Reports → Status report**
(`/admin/reports/status`), where the "trusted host patterns not configured"
finding is downgraded from an error to a warning on proxied sites.

## How to use it

For most sites, enabling the module is all you do — it will auto-detect the proxy
chain and resolve client IPs correctly. If you know your proxy IPs (the
recommended production setup), pin them explicitly in `settings.php` instead and
the module stands down. If a site is not behind a proxy at all, disable the
behaviour with `$settings['reverse_proxy'] = FALSE;`. All three of these are
covered in [Configuration](configuration/index.md).
