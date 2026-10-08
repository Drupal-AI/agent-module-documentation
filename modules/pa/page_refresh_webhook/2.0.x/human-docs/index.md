# Page Refresh WebHook — manual setup guide

**Page Refresh WebHook** (`page_refresh_webhook`) sends an outbound HTTP **POST** to
a URL you configure whenever a node of a chosen content type is saved, so an
external system — a static‑site builder, a crawler, a CDN, or a cache — can rebuild
or refresh the page that just changed. It is a small building block for decoupled,
headless, and static‑build workflows.

On this **2.0.x** branch the request is **not** sent during the save. Saving a node
adds an item to a queue, and the queue worker sends it on the next cron run — so a
slow or unreachable endpoint can never delay editing or hold the save transaction
open. If the endpoint is down the queue retries; if the endpoint rejects the request
(for example HTTP 403) the item is dropped and the reason logged; repeated saves of
the same URL within one run are de‑duplicated.

The key thing to understand about its "webhook" direction: this module **calls out**
to your endpoint. It exposes **no inbound route** that outsiders could trigger — its
only route is the admin settings form. Authentication, when you use it, is an
**API key sent as a request header** on the outgoing POST, and the key's value is
stored securely via the **Key** module, never in the module's own configuration.

Compared with the **1.0.x** branch, 2.0.x requires Drupal 11.2+ and PHP 8.3+, adds
the queue‑on‑cron behavior and a proper settings form with a config schema, uses
class‑based hook implementations, and moves its trigger and sender logic into
services you can decorate. If you upgrade from 1.x, run `drush updb` afterwards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Key module)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — set the endpoint, the API key via a
   Key entity, the content types to watch, the crawl depth, and how requests are
   sent on cron.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Page Refresh WebHook**
(`/admin/config/services/page-refresh-webhook`, config route
`page_refresh_webhook.settings`), gated by the **Administer site configuration**
permission. The API key is created and stored with the **Key** module at
**Configuration → System → Keys** (`/admin/config/system/keys`).
