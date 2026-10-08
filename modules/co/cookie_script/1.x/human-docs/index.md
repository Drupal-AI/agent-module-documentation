# Cookie-Script — manual setup guide

**Cookie-Script** (`cookie_script`) integrates the commercial
[Cookie-Script.com](https://cookie-script.com/) consent service into Drupal. It adds
the Cookie-Script consent banner and the script‑blocking that service provides, so
your analytics, marketing, and embed scripts can be held back until the visitor
agrees. The consent logic itself lives in Cookie-Script's hosted product — this
module is the Drupal‑side wiring.

You need a **Cookie-Script account** and its ID; the module does nothing until you
enter that ID on its settings form. Once configured, the Cookie-Script code is
loaded on your pages, which means that third‑party origin is added to every page.

Keep the compliance reality in mind: a banner only achieves compliance if the
scripts that set cookies actually **respect consent**. Configure the Cookie-Script
service to block analytics, marketing, and embed scripts until the visitor consents,
and disclose the third‑party consent service itself in your privacy policy. Your
Cookie-Script ID is an account identifier (configuration), not a secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Cookie-Script ID.

## Where it lives in the admin menu

Once enabled, configure the module at **`/admin/config/cookie_script`**.
