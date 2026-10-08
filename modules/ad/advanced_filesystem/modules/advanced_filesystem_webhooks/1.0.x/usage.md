Fires outbound HMAC-signed HTTP webhooks to Slack, Teams, Zapier, n8n or any custom endpoint whenever files are uploaded or deleted (and on antivirus/quota/LGPD events from sibling Advanced Filesystem sub-modules).

---

Advanced Filesystem: Webhooks is the notification bridge for the Advanced Filesystem suite. It listens to file-entity lifecycle hooks and to internal events published by other sub-modules, then delivers a JSON payload to every configured endpoint that has subscribed to the matching event. Each endpoint carries its own URL, optional HMAC secret, event subscriptions and active flag, all managed from a single admin form. Delivery is asynchronous by default: events are enqueued and drained by a cron queue worker that retries failed deliveries up to a configurable maximum before giving up. A synchronous mode is available for low-volume sites. Every delivery attempt — success or failure — is written to a delivery-log table (event, endpoint URL, HTTP status, attempt number, error) that admins can browse and that cron prunes on a retention schedule. The module ships no field types, entities or Drush commands; it is a thin, queue-backed HTTP dispatcher wired to Drupal's file hooks.

---

- Post a Slack incoming-webhook message every time an editor uploads a new file.
- Notify a Microsoft Teams channel when a file is deleted from the site.
- Trigger a Zapier or n8n automation flow on file uploads to sync assets to an external DAM.
- Alert an operations webhook when the antivirus sub-module reports an infected upload.
- Send a webhook to a monitoring service when a user exceeds their storage quota.
- Forward LGPD/GDPR personal-data findings to a compliance intake endpoint.
- Fan out the same file-upload event to several endpoints (Slack + a custom API) at once.
- Sign every payload with a per-endpoint HMAC secret so receivers can verify authenticity.
- Run deliveries asynchronously through the queue so slow receivers never block file saves.
- Retry transient webhook failures automatically up to a configurable attempt limit.
- Deliver synchronously (inline) on small sites where cron latency is undesirable.
- Include a site identifier in every payload so one receiver can distinguish staging from production.
- Subscribe different endpoints to different event sets (uploads to one, deletions to another).
- Temporarily disable an endpoint without deleting it via its active flag.
- Send a synthetic test.ping to any endpoint to validate connectivity before going live.
- Audit recent webhook traffic and failures from the built-in delivery-log page.
- Keep the delivery log tidy with an automatic cron-based retention window.
- Point a webhook at an internal microservice that resizes or re-processes newly uploaded files.
- Drive a CI/CD or cache-warming pipeline off file-change events.
- Integrate file events with incident-response tooling (PagerDuty-style HTTP receivers).
- Feed a data-warehouse ingestion endpoint with a stream of file lifecycle events.
- Notify a headless/decoupled front end to invalidate its own cache when a file changes.
