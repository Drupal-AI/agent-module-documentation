# Country Path — manual setup guide

**Country Path** (`country_path`) extends the
[Domain](https://www.drupal.org/project/domain) module so that a single hostname
can serve several "countries," each distinguished by the **first segment of the
URL path** rather than by a separate subdomain. Instead of running `usa.example.com`
and `fra.example.com`, you run `example.com/usa` and `example.com/fra` — one host,
multiple country sites. This is ideal when you want per‑country content and URLs
but don't want to buy, configure, and certificate a subdomain or TLD for each
market.

Under the hood it works with Domain's existing entities. Each domain record gains
a **country path prefix** (stored as the `country_path.domain_path` third‑party
setting) that you enter right on the domain edit form. On every request the module
reads the first path segment, matches it to the domain with that prefix (falling
back to the default domain when the prefix is empty or unknown), strips the prefix
so routing and controllers see a clean internal path, and re‑adds it to every
generated link. A dedicated `url.country` cache context keeps render caching
correct per country.

If core's **Language** module is enabled, Country Path also registers its own URL
language‑negotiation plugin so language can be detected from the path prefix (even
when it sits after the country segment, e.g. `example.com/usa/fr/...`) or from a
per‑language domain. It wires this negotiator in automatically on install.

The module requires the **Domain** module and PHP 7.3+/8. It has no permissions,
no Drush commands, and no global settings page — all configuration is per‑domain
plus the core language‑detection UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain.
2. [Configuration](configuration/index.md) — set a country prefix on each domain,
   optional domain aliases, and the language negotiator.

## Where it lives in the admin menu

There is no settings page of its own. You configure country prefixes on the
**Domain records** screen at **Configuration → Domains**
(`/admin/config/domain`), and you order the language negotiator at
**Configuration → Regional and language → Detection and selection**
(`/admin/config/regional/language/detection`).

## How to use it

Add or edit a domain record and, in the **Canonical hostname** field, append the
country prefix to the hostname — for example `example.com/usa`. When you save,
Country Path splits the trailing segment off, keeps the hostname as `example.com`,
and stores `usa` as the domain's country path. Repeat for each country, all
sharing the same hostname (the module relaxes Domain's unique‑hostname rule so
that's allowed). From then on, requests to `example.com/usa/...` resolve to the
USA domain automatically, and links generated while that domain is active get the
`/usa` prefix. See [Configuration](configuration/index.md) for the full walkthrough.
