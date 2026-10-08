# Entity Webhook — manual setup guide

**Entity Webhook** (`entity_webhook`) turns Drupal into a webhook hub. Its core
module **receives inbound webhooks** — external services POST JSON to an endpoint
on your site, and the module creates or updates ("upserts") content entities from
that payload, all configured through the admin UI with no custom code. Two
optional submodules extend it the other way: **Broadcast** sends *outbound*
webhooks when your entities change, and **Polling** pulls data from external APIs
on a schedule and feeds it through the same pipeline.

On the inbound side you build a small configuration hierarchy: an **Endpoint**
(the target entity type and optional bundle), a **Source Type** under it (how to
verify the request and how to map payload fields into entity fields, using
JSONPath expressions like `$.order.customer.email`), and **Field Mappings** that
can transform values and mark identifier fields for upsert matching. Webhooks are
accepted immediately and processed on cron, so keep cron running.

> **Set up request verification.** Each inbound **Source Type** lets you choose a
> **verification plugin** — **HMAC signature**, **API key**, or **IP/domain
> whitelist** — that authenticates the sender. Select one on every Source Type so
> that only your intended service can post to the endpoint, use a strong shared
> secret, serve the endpoint over **HTTPS**, and map only the fields you need.

The **Broadcast** submodule (outbound) can HMAC-sign the requests it sends and
retries with exponential backoff, logging deliveries for auditing. Because it
sends HTTP requests out to a URL you configure, point subscriptions only at
destinations you trust and sign the payloads so the receiver can verify them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   core module and only the submodules you need.
2. [Configuration](configuration/index.md) — building inbound endpoints (and the
   verifier you must configure), outbound broadcasts, and scheduled polling.

## Where it lives in the admin menu

- **Inbound webhooks** — **Configuration → Services → Entity Webhook**
  (`/admin/config/services/entity-webhook/endpoints`).
- **Outbound endpoints** (Broadcast submodule) —
  `/admin/config/services/entity-webhook/broadcast/endpoints`.
- **Polling** (Polling submodule) —
  `/admin/config/services/entity-webhook/polling`.
