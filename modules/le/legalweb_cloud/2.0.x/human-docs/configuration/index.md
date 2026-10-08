# Configuration

LegalWeb Cloud has two small jobs for you — connect the site to your legalweb.io
account, and choose which services and legal components to display — after which
the service does the rest. Most of the intelligence lives in legalweb.io; the
module fetches and inserts what it returns.

## Connect to legalweb.io

In the module's settings, enter the **license key / API identifier** (the `guid`)
that legalweb.io issued for your subscription. This is what authorises the module
to fetch your legal texts and consent configuration. Once it is set, the module
can pull down your consent popup, notices, privacy information, and imprint.

## Choose services and components

Your remaining task is to **select the services you use** and fill in a few input
fields. From that, legalweb.io generates:

- the **consent popup** and the cookie / services notice;
- **control of services and embeddings** (what loads before consent);
- the **data protection information**;
- the **imprint** (with an expanded generator in the cloud version).

You can surface the imprint via a block, a dedicated page, or a token.

## Store the license key safely

The API `guid` is stored in the module's configuration. Treat it as a secret:

- Store the value in an environment variable with DDEV's dotenv command — for
  example `ddev dotenv set .ddev/.env --legalweb-guid=<value>` — then
  `ddev restart`. Never commit `.ddev/.env`.
- Reference it through a **Key** entity backed by the environment provider where
  the workflow allows, so the raw key stays out of exported config and version
  control.

## Compliance

The module loads the JavaScript that legalweb.io returns as a library on every
non‑admin page (refreshed via cron). Remember that a popup being present does
not by itself make you compliant — configuring the services and texts correctly
is still your responsibility, and 100% conformity cannot be guaranteed by the
plugin alone.

## Save

Save the settings, then load a front‑end page and confirm the consent popup and
the other generated components appear as expected.
