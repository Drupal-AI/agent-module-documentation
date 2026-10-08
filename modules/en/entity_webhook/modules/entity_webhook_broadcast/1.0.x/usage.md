<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Webhook Broadcast sends outbound, HMAC-signed webhooks to external systems whenever Drupal entities are created, updated, or deleted.

---

Entity Webhook Broadcast is the outbound half of Entity Webhook. Enable it to turn Drupal entity changes into HTTP callbacks: it hooks entity insert, update, and predelete, matches each event against configured **Outbound Endpoints** (entity type, bundle, watched CRUD events, and optional Condition API filters), and for every matching endpoint enqueues a delivery to each of its active **Subscriptions**. A subscription carries the destination URL, an optional HMAC shared secret and signing algorithm, and retry configuration. The payload is assembled from **Outbound Field Mappings** using outbound value resolvers (entity field, entity reference traversal, field component, static value) and optional value mutations, then POSTed as JSON by the Guzzle HTTP client with an `X-Webhook-Signature` header when signing is enabled. Deliveries run through a queue during cron; failures are retried with exponential backoff (`base_delay * 2^(attempt-1)`) up to the subscription's max attempts, after which the delivery is abandoned. Every attempt is written to an OutboundDeliveryLog content entity for auditing, and a Test Webhook form lets you fire a sample delivery from the admin UI. Requires the parent `entity_webhook` module; configuration lives at `/admin/config/services/entity-webhook/broadcast/endpoints` and is gated by the `administer entity_webhook_broadcast` permission.

---

- Notify an external CRM whenever a node or user is created or updated in Drupal.
- Push new or changed content to a downstream cache, search index, or static site build.
- Send order or subscription changes to an ERP or fulfilment system.
- Broadcast only published nodes by attaching a Condition API filter to the endpoint.
- Watch a specific bundle (e.g. only `article` nodes) rather than a whole entity type.
- Fire outbound webhooks on delete so downstream systems can remove the record too.
- HMAC-sign outbound payloads so the receiver can verify authenticity and integrity.
- Choose the HMAC signing algorithm per subscription, or disable signing with `none`.
- Fan out one entity event to several destinations by adding multiple subscriptions.
- Shape the outbound JSON exactly, keying each value by a chosen output key.
- Include values from referenced entities via the entity_reference_field resolver.
- Emit constant metadata (source name, environment) with the static_value resolver.
- Transform outbound values (timestamp format, price conversion, mapping) with mutation plugins.
- Retry transient delivery failures automatically with exponential backoff.
- Cap retries per subscription with a max-attempts setting and mark exhausted deliveries abandoned.
- Audit and debug deliveries through per-subscription OutboundDeliveryLog entries.
- Inspect the last HTTP status and response body captured for each delivery attempt.
- Send a one-off test webhook from the admin UI before enabling a subscription.
- Add a custom outbound value resolver plugin for bespoke payload sourcing.
- Deliver asynchronously via cron or a queue runner to avoid slowing content saves.
