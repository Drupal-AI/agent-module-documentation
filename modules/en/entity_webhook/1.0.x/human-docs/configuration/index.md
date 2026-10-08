# Configuration

Entity Webhook is configured entirely through the admin UI. Inbound receiving is
handled by the core module; outbound broadcasting and scheduled polling each live
in their own submodule and appear only when enabled.

> **Recommended first step:** select a **verification plugin** on every inbound
> **Source Type** — HMAC signature, API key, or IP/domain whitelist — so that the
> endpoint authenticates its sender before processing a payload. Use a strong
> shared secret and bring each Source Type's verification online before it starts
> receiving real traffic.

## Inbound webhooks

Go to **Configuration → Services → Entity Webhook**
(`/admin/config/services/entity-webhook/endpoints`). Inbound configuration is a
three-level hierarchy:

1. **Create a Webhook Endpoint.** Choose the target **entity type** (for example
   Node) and an optional **bundle**. The endpoint is the "what should this create
   or update?" layer.

2. **Add a Source Type** under the endpoint. This is where verification and
   mapping live:
   - **Verification** — choose **HMAC signature validation**, **API key
     authentication**, or **IP/domain whitelist** so the sender is authenticated.
     Use a strong shared secret and serve the endpoint over HTTPS.
   - **Field mappings** — map incoming payload values into entity fields using
     **JSONPath** expressions (for example `$.order.customer.email`). Optionally
     transform values with mutation plugins: timestamp formatting, string/regex
     replace, value mapping, price conversion, JSON encoding, and array
     reshaping.
   - **Identifiers** — mark one or more field mappings as identifiers so incoming
     data is matched to an existing entity (upsert). Matching on more than one
     field gives you a composite key.

3. **Your endpoint URL** is then:
   `https://yoursite.com/webhook/{endpoint_id}/{source_type_id}` — this is where
   the external service POSTs its JSON.

Incoming webhooks are accepted immediately and processed on cron, so keep cron
running (or use a queue runner for near-real-time processing).

## Outbound webhooks (Broadcast submodule)

Go to `/admin/config/services/entity-webhook/broadcast/endpoints` (available when
the **Broadcast** submodule is enabled):

1. **Create an Outbound Endpoint.** Select the **entity type**, **bundle**, and
   which **CRUD events** (create, update, delete) to watch. Optionally add
   **conditions** (via Drupal's Condition API) to filter which events fire — for
   example only published nodes.
2. **Add a Subscription** under the endpoint. Provide the **destination URL**, the
   **HMAC signing** settings (algorithm and shared secret), and **retry**
   configuration (max attempts and base delay for exponential backoff).
3. **Add Field Mappings** under the subscription to build the outbound JSON
   payload from entity fields, including traversal of entity references.

Deliveries are logged for auditing, debugging, and retry tracking. Sign the
payloads so the receiver can verify they came from you, and treat the destination
URL as trusted.

## Scheduled polling (Polling submodule)

Go to `/admin/config/services/entity-webhook/polling` (available when the
**Polling** submodule is enabled):

1. **Create a polling configuration** that references an existing inbound
   **Webhook Endpoint** and **Source Type** — polled data flows through the same
   mapping pipeline as inbound webhooks.
2. **Set a cron expression** for the schedule and choose a **polling provider**
   plugin. SHA-256 hash-based change detection skips records that have not
   changed since the last poll.

## Processing the queues

Both inbound and outbound webhooks are processed asynchronously on cron. Make
sure cron runs regularly, or configure a queue runner if you need delivery closer
to real time.
