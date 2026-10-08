<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Webhook Polling pulls data from external APIs on a cron schedule and feeds it through Entity Webhook's inbound processing pipeline.

---

Entity Webhook Polling adds pull-based ingestion to Entity Webhook for sources that do not send webhooks. Each polling configuration is a small config entity that points at an existing inbound **Webhook Endpoint** and **Source Type**, carries a **cron expression** (e.g. `*/15 * * * *`), and names a **polling provider** plugin plus its configuration. On every Drupal cron run the module loads all enabled configurations, uses the dragonmantank/cron-expression library to decide which are due, instantiates each due provider, and calls its `fetch()` method to return an array of payloads. Every payload is hashed with SHA-256 (keyed by the payload's `id`, or by the hash itself when no id is present) and compared against the last stored hash; only new or changed records are enqueued, then processed by the parent module exactly like an inbound webhook (JSONPath extraction, mutations, entity upsert or delete). Providers are a plugin type, so bespoke API clients can be added. Requires the parent `entity_webhook` module; configurations are managed at `/admin/config/services/entity-webhook/polling` under the `administer entity_webhook_polling` permission.

---

- Import records from an external REST API that does not offer outbound webhooks.
- Poll a partner feed every few minutes and upsert the results as Drupal entities.
- Reuse an existing Webhook Endpoint and Source Type for polled data (same field mappings).
- Schedule polling with a standard cron expression (e.g. `*/15 * * * *`, `0 * * * *`).
- Run several independent polling configurations against different sources.
- Skip unchanged records automatically with SHA-256 hash-based change detection.
- Deduplicate records by their external `id`, or by content hash when no id exists.
- Enable or disable an individual polling configuration without deleting it.
- Feed polled payloads through the same JSONPath mapping and mutation pipeline as webhooks.
- Create or update entities from polled data using identifier-based upsert.
- Delete entities from polled data when the source type's operation is delete.
- Write a custom polling provider plugin for a specific third-party API.
- Pass provider-specific settings (endpoint URL, credentials, paging) via provider config.
- Throttle load by choosing a cron expression coarser than your Drupal cron frequency.
- Run ingestion entirely server-side on cron, with no inbound endpoint exposed.
