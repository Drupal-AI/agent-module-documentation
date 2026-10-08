<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Webhook ingests inbound JSON webhooks and upserts Drupal content entities through a configuration-driven admin UI, with optional outbound-broadcast and scheduled-polling submodules.

---

Entity Webhook turns external HTTP events into Drupal content. External services POST a JSON body to a receiver URL (`/webhook/{endpoint_name}/{source_type}`); the module extracts values from the payload using JSONPath expressions, optionally transforms each value with a mutation plugin, and then creates, updates, or deletes a target content entity. Existing entities are matched with one or more identifier field mappings (a composite key), giving true upsert behaviour. Configuration is a three-tier hierarchy of config entities — Webhook Endpoint (the target entity type and optional bundle), Webhook Source Type (request verification and the create/delete operation), and Webhook Field Mapping (which payload value maps to which entity field). Incoming requests are verified with a pluggable verification plugin (HMAC signature, API key, or IP/domain whitelist), then queued and processed asynchronously during cron for resilience — or handled synchronously when an endpoint opts in. Pre-save, post-save, and batch-complete events let custom code react to or veto each upsert. Two optional submodules extend it in the other directions: **Entity Webhook Broadcast** watches entity create/update/delete events and sends outbound, HMAC-signed webhooks with condition filtering, exponential-backoff retries, and delivery logging; **Entity Webhook Polling** pulls data from external APIs on a cron schedule and feeds it through the same inbound pipeline. The module is fully pluggable — verification, value resolution, field mutation, payload processing, outbound value resolution, and polling providers are all plugin types — and requires PHP 8.3, Drupal 10.3+ or 11, and the softcreatr/jsonpath and dragonmantank/cron-expression libraries.

---

- Sync records from an external CRM into Drupal nodes or custom entities via webhook.
- Create or update user accounts from an identity provider's outbound webhooks.
- Ingest e-commerce orders posted by an external storefront and upsert them as Commerce orders.
- Keep taxonomy terms in step with an external product catalog feed.
- Upsert entities keyed by an external system's ID using a composite-key identifier mapping.
- Delete Drupal entities when the source system reports a record was removed (delete operation).
- Extract nested payload values with JSONPath expressions like `$.order.customer.email`.
- Map several payload fields to entity fields, each with its own resolver and mutation.
- Convert Unix timestamps or date strings into Drupal date fields with the timestamp_format mutation.
- Translate external status codes to Drupal values with the map_values lookup mutation.
- Convert integer cents to a decimal price with the price_cents_to_decimal mutation.
- Clean or reformat incoming strings with the string_replace or regex_replace mutations.
- Authenticate incoming requests with an HMAC signature shared secret.
- Authenticate incoming requests with an API key sent in a header or query parameter.
- Restrict a source type to trusted sender IPs or domains with the whitelist verifier.
- Split a batch payload (an array of records) into one upsert per record with a payload processor.
- Reconcile a full incoming record set after batch processing using the batch-complete event.
- Process webhooks asynchronously through the queue during cron for high-volume ingestion.
- Handle low-volume webhooks synchronously and return the upsert result in the HTTP response.
- Broadcast entity create/update/delete events to an external system as outbound webhooks.
- Send only qualifying events outbound by attaching Condition API plugins (e.g. published nodes only).
- HMAC-sign outbound payloads so the receiving system can verify their integrity.
- Retry failed outbound deliveries automatically with exponential backoff and a max-attempts cap.
- Audit and debug outbound deliveries through per-subscription delivery logs.
- Send a test outbound webhook from the admin UI before going live.
- Poll an external API on a cron schedule (e.g. every 15 minutes) and ingest changed records.
- Skip unchanged polled records automatically using SHA-256 hash change detection.
- Add custom verification, value-resolver, mutation, payload-processor, outbound-resolver, or polling-provider plugins for bespoke integrations.
