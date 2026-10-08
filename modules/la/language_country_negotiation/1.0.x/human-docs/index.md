# Language Country Negotiation — manual setup guide

**Language Country Negotiation** (`language_country_negotiation`) adds a
**country‑aware language negotiation method** to Drupal. It lets visitors browse
your site using URLs that combine a language and a country, such as:

- `example.com/en-ca` — English in Canada
- `example.com/fr-ca` — French in Canada
- `example.com/de-de` — German in Germany
- `example.com/en-gb` — English in Great Britain

From that `{language}-{country}` path prefix the module tells Drupal's language
manager which language to serve *and* records the visitor's current country through
a lightweight **CurrentCountry** service that your downstream code can read (for
example to apply country‑specific tax labels or indexation options). Visitors can
also browse without a prefix, landing in an "international" state where other
negotiation methods (like plain path‑prefix) take over — handy for a country‑picker
banner.

It's built around fieldable **country entities**, so you can configure which
languages are allowed per country and extend countries with your own fields for
business logic. It depends on core's **Interface Translation** (`locale`) and
**Path Alias** (`path_alias`) modules and lives in the Multilingual package.

Please note this is an **alpha release** and still under active development —
several planned options (custom prefix patterns, excluding admin pages, strict
negotiation) are on the roadmap but may not all be present yet. Test it against your
core version before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add languages and countries, activate
   the country‑aware detection method, and set up fallbacks.
