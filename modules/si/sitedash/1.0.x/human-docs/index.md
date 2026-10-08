# SiteDash — manual setup guide

**SiteDash** (`sitedash`) connects your Drupal site to the SiteDash.io
monitoring and management service. Once you have entered your SiteDash token, it
reports the site's audit and health data to a centralized SiteDash dashboard,
where you can monitor and manage the site alongside others.

The problem it solves is centralized oversight. Rather than checking each site
individually, SiteDash pulls audit and health information together in one
dashboard. It does this by integrating automatically with the **Audit Export**
module: after you authenticate, SiteDash configures the remote post URL,
authentication headers and site identifier for you, so there is very little
manual setup. An optional "Override Remote Post" setting lets SiteDash manage
Audit Export's remote configuration centrally on your behalf.

The module needs configuration to do anything: you must enter your SiteDash
token on its settings page before it connects. It depends on the **Audit Export**
module (and its submodules), requires Drupal 10 or 11, and you will need a
SiteDash.io account with an authentication token. It provides its own permission
but has no access‑control role beyond that.

**A word on what leaves your site.** SiteDash sends site audit and health data to
the external SiteDash.io service. That can include module, version and
configuration details — essentially operational fingerprinting data — so keep it
to a SiteDash account you trust, and authenticate over HTTPS. Store the SiteDash
token as a secret (an environment variable or a Key entity) rather than pasting
it anywhere it could be committed to version control.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and Audit Export).
2. [Configuration](configuration/index.md) — enter your SiteDash token and
   connect the site.

## Where it lives in the admin menu

After enabling the module, go to **`/admin/config/services/sitedash`** to enter
your SiteDash token. Once authenticated, the module configures the remote post
settings automatically.
