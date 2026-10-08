# Page Refresh WebHook — manual setup guide

**Page Refresh WebHook** (`page_refresh_webhook`) sends an outbound HTTP **POST**
to a URL you configure whenever a node of a chosen content type is saved. That lets
an external system — a static‑site builder, a crawler, a CDN, or a cache — know it
should rebuild or refresh the page that just changed. It is a small building block
for decoupled and static‑build workflows.

The key thing to understand about its "webhook" direction: this module **calls out**
to your endpoint; it does **not** expose an inbound endpoint on your Drupal site
that outsiders can trigger. Authentication, when you use it, is an **API key sent as
a request header** on the outgoing POST, and the key's value is stored securely via
the **Key** module rather than in the module's own configuration.

This is the **1.0.x** branch (an early release candidate) for Drupal 9, 10, and 11.
The later **2.0.x** branch reworks it for Drupal 11.2+/PHP 8.3+, queues the requests
so saving content never waits on the endpoint, and adds a dedicated settings form —
see the 2.0.x guide if you are on newer Drupal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Key module)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — set the endpoint, the API key via a
   Key entity, the content types to watch, and the crawl depth.

## Where it lives in the admin menu

The module is configured through its settings (see the module's `README.md` for the
exact location on this branch). The API key is created and stored with the **Key**
module at **Configuration → System → Keys** (`/admin/config/system/keys`).
