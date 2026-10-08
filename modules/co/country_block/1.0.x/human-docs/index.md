# Country Block — manual setup guide

**Country Block** (`country_block`) lets site administrators block access to their
Drupal site based on the visitor's country. It uses the
[Smart IP](https://www.drupal.org/project/smart_ip) module to work out a visitor's
country from their IP address, and if that country is on your blocklist, the visitor
is denied access and shown a message you configure.

The problem it addresses is coarse geographic gating: restricting content for
regional licensing reasons, meeting a legal requirement, or cutting down malicious
traffic from particular parts of the world. You manage the blocklist with a simple
list of two‑letter country codes, set a custom "access denied" message, and the
configuration is protected by its own dedicated permission.

It's important to be clear‑eyed about what this can and cannot do. **Country
blocking is a coarse, best‑effort gate — not a strong security boundary.** GeoIP
lookups are approximate (the underlying databases are imperfect), and a visitor's
apparent IP can be changed with a VPN or proxy — and spoofed via request headers
unless Drupal's trusted‑proxy settings are configured. A determined user can get
around it. Use it for compliance and UX geo‑gating, **not** to protect sensitive
content and **not** as your only line of access control. It has no per‑content
access‑control role.

The module depends on **Smart IP**, which in turn needs a configured GeoIP data
source to work at all. It works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up Smart IP.
2. [Configuration](configuration/index.md) — grant the permission, add blocked
   countries, and set the message.

## Where it lives in the admin menu

Country Block's settings live at **Configuration → System → Country Block**
(`/admin/config/system/country-block`). Access to that page is controlled by the
**Administer Country Block** permission.
