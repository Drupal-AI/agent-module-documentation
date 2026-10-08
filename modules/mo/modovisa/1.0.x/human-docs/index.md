# Modovisa — manual setup guide

**Modovisa** (`modovisa`) adds the Modovisa real‑time visitor‑tracking snippet to
your Drupal site. Once you enable it and paste in your tracking token, the module
injects a single asynchronous script into the `<head>` of every non‑admin page, so
Modovisa can record sessions, journeys, and conversions. It is a lightweight
marketing/analytics integration with no hard dependencies — sites without a store
work fine.

The one thing that makes Modovisa "go" is your **tracking token**, which you get
from your Modovisa project. Until you enter it and tick the enable checkbox on the
settings form, no script is added. The loader is cache‑friendly: it works with the
page cache, BigPipe, and CDNs, and runs only once per request.

If you run **Drupal Commerce**, Modovisa can also report purchases. When a checkout
completes it sends the order total, currency, and order number to Modovisa so you
can track e‑commerce conversions. Commerce is entirely optional — the tracking
snippet works on any site with or without a store.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable tracking and enter your
   tracking token, plus the domain and privacy notes.

## Where it lives in the admin menu

Once enabled, Modovisa's settings live at **Configuration → System → Modovisa**
(`/admin/config/system/modovisa`). Access is gated by the **Administer Modovisa**
(`administer modovisa`) permission. See [Configuration](configuration/index.md) for
the field‑by‑field walkthrough.
