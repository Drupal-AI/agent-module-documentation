# GeoDeny — manual setup guide

**GeoDeny** (`geodeny`) blocks visitors by country. When a request comes in, it
looks up the country of the client's IP address and, if that country is on your
configured deny list, replaces the response with an empty **HTTP 400**. It's a
simple, site‑wide way to apply coarse country‑level restrictions — for compliance
or sanctions reasons, to loosely enforce licensing territories, or to cut down
abuse and scraping from particular regions.

The country lookup comes from the **ip2country** module, which provides the
geolocation database and lookup service GeoDeny depends on. You manage the list of
blocked countries/regions from a single admin form; there's nothing to configure
per page or per route — the block applies to the whole site.

Two important limits are worth understanding before you rely on it. First, **IP
geolocation is coarse and spoofable**: it identifies a country fairly reliably but
can be defeated by VPNs and proxies, and it depends on your reverse‑proxy/
trusted‑proxy settings being correct so that the *real* client IP is seen.
Second, the block runs late in the request — the response body is discarded, but
the page has effectively already been built — so GeoDeny is an output‑level
deterrent, **not a hard security boundary or a substitute for a firewall/WAF or
per‑route access control**. IP addresses that can't be resolved to a country are
not blocked (it fails open). Treat it as one loose layer among others, not as your
only defence.

It depends on the **ip2country** module and supports **Drupal 9 and 10**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up the ip2country database.
2. [Configuration](configuration/index.md) — choose which countries/regions to
   block.

## Where it lives in the admin menu

GeoDeny's settings form is at **Configuration → Web services → GeoDeny**
(`/admin/config/services/geodeny`, config route `geodeny.config_form`), behind the
**Administer site configuration** permission. That's the only screen — see
[Configuration](configuration/index.md).
