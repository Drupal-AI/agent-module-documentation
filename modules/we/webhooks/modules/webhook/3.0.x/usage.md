<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional submodule of Webhooks that persists every **received** (incoming) webhook as a `webhook` content entity, giving you an admin-listable audit trail of inbound payloads.

---

The `webhook` submodule defines a `webhook` content entity (base table `webhook`) with fields `title`, `headers`, `payload`, and `created`, plus standard add/edit/delete forms, a list builder, and Views data. Its `WebhookSubscriber` listens on the parent module's `webhook.receive` event and, for each received webhook, creates and saves a `webhook` entity storing the delivery uuid-derived title and the JSON-encoded headers and payload. Managed at `/admin/content/webhook` behind the `access webhook overview` permission. It is a thin persistence/audit layer on top of the `webhooks` framework — enable it when you want received webhooks recorded as content; the core receive→event flow works without it.

---

- Keep a persistent record of every inbound webhook the site receives.
- Audit third-party webhook deliveries (headers + payload) after the fact.
- Browse received webhooks in an admin list at `/admin/content/webhook`.
- Inspect a single received webhook's stored headers and payload.
- Expose received webhooks to Views for custom reporting.
- Debug an integration by seeing exactly what a remote service posted.
- Store the delivery UUID (as the entity title) for correlating with the sender.
- Retain inbound payloads as content entities (revisionable-friendly base entity).
- Delete old received-webhook records via the entity delete form.
- Gate access to the received-webhook log with `access webhook overview`.
- Build a moderation/notification flow off newly created `webhook` entities.
- Serve as a reference implementation of subscribing to `webhook.receive`.
- Verify what a sender delivered when a signature check fails, by comparing stored payloads.
- Provide a canonical `/webhook/{id}` view page for a single recorded delivery.
- Add fields/behaviour to received webhooks by extending the `webhook` content entity.
- Correlate inbound deliveries with outbound sends during integration testing.
- Keep an append-only trail of inbound automation-platform (Zapier/Make/n8n) calls.
