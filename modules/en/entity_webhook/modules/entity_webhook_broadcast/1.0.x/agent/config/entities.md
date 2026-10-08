<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Broadcast entities, routes & permission

Schema: `config/schema/entity_webhook_broadcast.schema.yml`. All admin routes
(`entity_webhook_broadcast.routing.yml`) require `_permission: 'administer entity_webhook_broadcast'`
(`entity_webhook_broadcast.permissions.yml`, `restrict access: true`) and hang under
`/admin/config/services/entity-webhook/broadcast/…`. Menu link `entity_webhook_broadcast.admin`
(*Outbound Broadcasts*) is a child of the parent module's `entity_webhook.admin`.

## outbound_endpoint (config)

`src/Entity/OutboundEndpoint.php`, prefix `entity_webhook_broadcast.outbound_endpoint.*`. Keys:

- `id`, `label`, `status` (bool).
- `entity_type` — watched entity type.
- `entity_bundle` — watched bundle; empty = all bundles.
- `events` (string[]) — CRUD events to watch: `insert`, `update`, `delete` (`getEvents()`).
- `conditions` (sequence of `condition.plugin.[id]`) — Condition API plugins; `getActiveConditions()`,
  `getConditions()` (a condition plugin collection).

Collection `/admin/config/services/entity-webhook/broadcast/endpoints`; add/edit/delete under it.

## outbound_subscription (config)

`src/Entity/OutboundSubscription.php`, prefix `entity_webhook_broadcast.outbound_subscription.*`.
Child of an endpoint. Keys (with defaults):

- `id`, `label`, `endpoint_id`.
- `url` — destination webhook URL (`getUrl()`).
- `secret` (nullable) — HMAC shared secret (`getSecret()`).
- `signing_algorithm` (default `sha256`) — passed to `hash_hmac`; `none` disables signing
  (`getSigningAlgorithm()`).
- `retry_max_attempts` (default 5), `retry_base_delay` (default 60 s) — `getRetryMaxAttempts()`,
  `getRetryBaseDelay()`.
- `active` (default TRUE).

Collection `…/broadcast/endpoints/{outbound_endpoint}/subscriptions`; add/edit/delete;
`…/subscriptions/{outbound_subscription}/delivery-logs` (log list) and `…/test` (`TestWebhookForm`).

## outbound_field_mapping (config)

`src/Entity/OutboundFieldMapping.php`, prefix `entity_webhook_broadcast.outbound_field_mapping.*`.
Child of a subscription. Keys:

- `id`, `label`, `subscription_id`.
- `resolver` (+ `resolver_config`) — `outbound_value_resolver` plugin ID (`getResolver()`).
- `output_key` — the key this value takes in the outbound JSON (`getOutputKey()`).
- `mutation_plugin` (+ `mutation_config`) — optional parent-module `field_value_mutation` plugin.

## outbound_delivery_log (content entity)

`src/Entity/OutboundDeliveryLog.php`, `#[ContentEntityType id: 'outbound_delivery_log']`, base table
`outbound_delivery_log` (created automatically on install; see `.install`). Base fields include
`subscription`, `entity_type`, `entity_id`, `event`, `payload`, `payload_hash`, `attempt`,
`max_attempts`, `status` (`pending` | `success` | `failed` | `abandoned`), `http_status`, response
body (first 1KB), `next_retry_at`. Setters: `setStatus()`, `setHttpStatus()`, `setNextRetryAt()`,
`incrementAttempt()`. A `ListBuilder` and `ViewsData` are provided.
