<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Webhook (entity_webhook) — agent index

Configuration-driven **inbound webhook ingestion**: an external service POSTs JSON to
`/webhook/{endpoint_name}/{source_type}`; the module extracts values with **JSONPath**, transforms
them with mutation plugins, and **upserts or deletes a Drupal content entity**. Package `Services`.
Version **1.0.0-alpha1** (version-dir 1.0.x). Core `^10.3 || ^11`, **PHP 8.3+**.
Provides the `administer entity_webhook` permission. No Drush.

Composer deps: **softcreatr/jsonpath** `^0.8` (JSONPath parsing, used via `Flow\JSONPath\JSONPath`),
**dragonmantank/cron-expression** `^3.3` (used by the Polling submodule), `ext-json`.

## Config-entity model (three tiers)

- `webhook_endpoint` — target entity type/bundle, allowed source-type IDs, `processing_mode`
  (`async` default | `sync`).
- `webhook_source_type` — belongs to an endpoint; `operation` (`upsert` default | `delete`),
  `verification_plugin` (+ config), optional `payload_processor` (+ config).
- `webhook_field_mapping` — belongs to a source type; `entity_field`, `is_identifier`, `resolver`
  (+ config, default `json_path`), optional `mutation_plugin` (+ config).

See [config/entities.md](config/entities.md) — entities, schema keys, routes, permission, admin UI.

## Runtime pipeline

Controller → verification → queue/sync → processor → resolvers/mutations → upsert/delete → events.
See [inbound/pipeline.md](inbound/pipeline.md) — `WebhookController`, `WebhookProcessor`,
`EntityUpsertService`/`EntityLookupService`, `JsonPathExtractor`, queue worker, and the
`entity_webhook.pre_save` / `post_save` / `batch_complete` events.

## Plugin types (4, defined here)

`value_resolver`, `field_value_mutation`, `webhook_verification`, `webhook_payload_processor`.
Built-in ids and their config keys → [plugins/plugins.md](plugins/plugins.md).

## Submodules (own doc trees)

- **entity_webhook_broadcast** — outbound webhooks on entity CRUD (HMAC-signed, retried, logged).
  → [../../modules/entity_webhook_broadcast/1.0.x/agent/start.md](../../modules/entity_webhook_broadcast/1.0.x/agent/start.md)
- **entity_webhook_polling** — cron-scheduled polling into the inbound pipeline.
  → [../../modules/entity_webhook_polling/1.0.x/agent/start.md](../../modules/entity_webhook_polling/1.0.x/agent/start.md)

## Operate

Install: `composer require drupal/entity_webhook` then enable `entity_webhook` (and only the
submodules you need). Configure at **Configuration → Services → Entity Webhook**
(`/admin/config/services/entity-webhook/endpoints`). Async endpoints require **cron** (or a queue
runner) to process the `entity_webhook_processor` queue. Always select a verification plugin on each
source type so incoming requests are authenticated.
