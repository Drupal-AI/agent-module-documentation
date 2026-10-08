# IPAbuse Firewall — manual setup guide

**IPAbuse Firewall** (`ipabuse`) connects your Drupal site to the community‑driven
[ipabuse.org](https://ipabuse.org) IP reputation database and uses it as a
lightweight firewall layer. Once configured with a free API key, it runs quietly
in the background: it blocks known‑malicious IPs before they can interact with
your site, and it reports failed login attempts back to the database to help
protect everyone else.

Three things happen automatically. **Request‑level blocking** checks every
incoming request against a locally cached blocklist and returns a `403 Forbidden`
immediately — before Drupal bootstraps a full page — to any IP on the list.
**Brute‑force reporting** sends each failed Drupal login attempt to ipabuse.org
(rate‑limited with Drupal's Flood API so the same IP isn't reported over and
over). **Cron‑based sync** refreshes your local blocklist on every cron run, so it
stays current without manual work. You control the abuse‑confidence **score
threshold** (0–100, default 75) that decides how bad an IP has to be before it's
blocked, and you can toggle blocking and reporting independently.

It's a good fit for any public Drupal site that gets login attempts, spam
registrations, or scraping and wants passive, maintenance‑free protection. As with
any IP‑based blocking, remember that shared IPs can produce false positives.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your API key, test the
   connection, sync the blocklist, and tune the score threshold.

## Where it lives in the admin menu

The settings page is at **Configuration → Security → IPAbuse Firewall**
(`/admin/config/security/ipabuse`). See [Configuration](configuration/index.md).
