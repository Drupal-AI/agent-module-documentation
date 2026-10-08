# cmlmerchant — manual setup guide

**cmlmerchant** (`cmlmerchant`) generates product feeds for **Google Merchant
Center**, **Yandex** and **VK** from your catalog, and serves them as XML/YML files
at fixed, stable URLs. If you run a Drupal Commerce catalog and want marketplaces
and shopping platforms to ingest your products, this module builds the feed files
they expect and keeps them up to date.

It reads products from a `catalog` taxonomy and, through its feed service, renders
the feeds to files under `sites/default/files/YML/` — for example
`cmlmerchant_google.xml`, `cmlmerchant_yandex.xml`, plus VK variants for realty,
transport, services and hotel listings. The generated files are then streamed back
from predictable paths such as `/cmlmerchant/google-feed.xml` and
`/cmlmerchant/yandex-feed.xml`, which you register with the relevant marketplace.

Feeds are regenerated automatically on **cron** and can also be rebuilt on demand
with the module's Drush command. A settings form controls what goes into the feeds,
and an admin‑only debug route helps you inspect feed building.

This module is **part of the `cml`/CML Starter family**: it depends on the
[`catalog`](https://www.drupal.org/project/catalog) and
[`cmlstarter`](https://www.drupal.org/project/cmlstarter) projects, so it expects a
CML Starter–style storefront structure to read from. Note that it is **not covered
by Drupal's security advisory policy**.

On the security side there's nothing alarming: the feed routes are read‑only and
simply stream pre‑generated files (gated by the ordinary **access content**
permission, appropriate for public product feeds), and the debug route is
restricted to site administrators. There are no anonymous mutation endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside its
   `catalog` and `cmlstarter` dependencies.
2. [Configuration](configuration/index.md) — configure feed generation, map Google
   categories, and find your feed URLs.

## Where it lives in the admin menu

The settings form is at **Configuration → cmlmerchant → Settings**
(`/admin/config/cmlmerchant/settings`), and a debug view sits at
`/cmlmerchant/debug` (administrators only).
