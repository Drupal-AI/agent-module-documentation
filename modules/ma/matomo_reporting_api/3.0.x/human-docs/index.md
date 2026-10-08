# Matomo Reporting API — manual setup guide

**Matomo Reporting API** (`matomo_reporting_api`) lets Drupal *read analytics back*
from a Matomo instance. Matomo (formerly Piwik) is the privacy‑friendly,
self‑hostable analytics platform, and beyond sending it tracking data, sites often
want to pull the numbers into Drupal — to show popular content, a visits dashboard,
referrer stats, or per‑page figures. This module is the client that authenticates
to a Matomo server's **Reporting API** and fetches that report data.

It is an integration library more than a finished feature: it provides the API
client and the plumbing, and what you actually display is built on top of it in
your own code, a block, or a view. The project ships an example submodule
(`matomo_reporting_api_example`) that demonstrates a block showing some Matomo
statistics. The required Matomo reporting PHP library is installed automatically
with Composer.

It is commonly paired with — and can reuse the configuration of — the separate
**Matomo Analytics** module (the one that adds the tracking snippet). If Matomo
Analytics is enabled, you can avoid entering the same server details twice. Matomo
Reporting API also works standalone.

One thing to treat carefully: the **Matomo authentication token is a credential**.
It grants read access to your analytics, which can itself be sensitive — visitor
data, popular pages, referrers — so it should be stored securely rather than in
plain configuration that lands in git, and the connection to Matomo should always
use a secure **HTTPS** URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Matomo server URL, site
   ID, and auth token, and store the token securely.

## Where it lives in the admin menu

Matomo Reporting API adds a settings form where you enter the connection details
for your Matomo server. This module is aimed at developers and site builders — it
has no end‑user UI; the value of the reports is realised through code or an example
block built on top of the client.
