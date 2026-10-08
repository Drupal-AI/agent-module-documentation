<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Webhook" transport to Headless CMS - Notify that delivers notification messages as JSON HTTP POST requests to a configured URL.

---

Headless CMS - Notify Webhook plugs an HTTP delivery channel into the Notify framework. When you create a `headless_notify_transport` and choose the **Webhook** plugin, you configure a destination URL and whether deliveries go through Drupal's queue. Each notification the Notify module produces for a consumer using this transport is sent as a `POST` with `Content-Type: application/json` and the message's JSON body (`{type, subType, params}`). By default (`use_queue = TRUE`) the send is enqueued to the `headless_cms_notify_webhook` queue and dispatched by a cron queue worker, so content saves are not blocked on the remote endpoint; disabling the queue sends synchronously. Delivery uses Drupal's shared Guzzle HTTP client (`connect_timeout` 5s). Outcomes are logged to the `headless_cms_notify_webhook` channel: a 404 from the destination is treated as a non-fatal "endpoint not implemented" warning, other client/connection errors are logged and raised as a `WebhookRequestException`. The transport URL is set by an administrator on the transport entity and validated with `FILTER_VALIDATE_URL`.

---

- Deliver content-change notifications to a frontend build hook or serverless function.
- Trigger a Next.js / Nuxt / Astro on-demand revalidation endpoint on entity changes.
- Ping a CI/CD or static-site rebuild webhook when caches are rebuilt.
- Notify a CDN or edge cache to purge when content updates.
- Send entity create/update/delete events to an external microservice.
- Queue webhook deliveries so editors' saves stay fast.
- Send webhooks synchronously when you need immediate delivery.
- Point different consumers at different webhook URLs.
- Reuse the same webhook transport across multiple consumers.
- Integrate with automation platforms (Zapier/Make/n8n) that accept JSON webhooks.
- Keep an external search index in sync via a webhook receiver.
- Fan out Drupal events to a message-relay endpoint.
- Log delivery success/failure per webhook for observability.
- Tolerate a not-yet-implemented endpoint (404) without failing the save.
- Retry delivery through the queue when the endpoint is temporarily down.
