<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Headless CMS bundles conveniences for running Drupal as a decoupled/headless backend, adding per-consumer preview of unpublished content and change notifications on top of the Consumers module.

---

Headless CMS is an umbrella project that fills gaps decoupled Drupal setups hit in practice. The base module itself is small: it declares the `administer headless_cms settings` permission, hangs a *Configuration → Headless CMS* menu page at `/admin/config/headless-cms`, and adds a shared "Headless CMS" vertical-tab group to the Consumers (`consumer`) entity form via `HeadlessCmsUtility::alterConsumerForm()`. All real functionality lives in five independently-enablable submodules. **Preview** lets editors open unpublished nodes and revisions in an external frontend through JSON:API preview routes, keyed by a per-render preview token; **Preview - NATS** publishes a message when a preview is saved so the frontend can live-reload. **Notify** dispatches entity create/update/delete and cache-rebuild events to configured consumers through pluggable transports; **Notify - Webhook** and **Notify - NATS** provide those transports (an HTTP POST to a configured URL, or a NATS subject publish). Configuration is per-consumer: each consumer entity gains fields for its preview/revision URLs, whether notifications are enabled, which transport and event types to use, and which entity types to watch. Because the module deliberately exposes content to API clients, it depends on `consumers` (Drupal 10.3+ / 11) and should be paired with carefully configured JSON:API, CORS and authentication.

---

- Run Drupal as a headless/decoupled CMS backend for a JavaScript or native frontend.
- Preview unpublished node content in an external frontend before publishing.
- Preview a specific node revision in the decoupled frontend.
- Give each API consumer its own preview and revision URL templates.
- Add a "Save Preview" button to node edit forms for enabled bundles.
- Live-reload a frontend preview when an editor re-saves a draft (via NATS).
- Notify a frontend when any watched entity is created, updated or deleted.
- Trigger a static-site rebuild / on-demand revalidation when Drupal's caches are rebuilt.
- Send change events to different frontends per consumer.
- Deliver notifications over HTTP webhooks to a configured endpoint.
- Deliver notifications by publishing to a NATS message broker.
- Queue webhook deliveries so content saves stay fast.
- Choose which entity types each consumer receives entity-operation notifications for.
- Restrict all Headless CMS administration behind a single `administer headless_cms settings` permission.
- Manage notify transports as config entities you can export and deploy.
- Encrypt preview tokens with an Encrypt profile for production hardening.
- Suppress entity notifications during migrations (with `migrate_utils`).
- Configure everything per-consumer from the standard Consumers admin UI.
- Integrate JSON:API preview includes so referenced draft entities resolve in the preview response.
- Build multi-frontend / multi-brand decoupled sites where each brand is a separate consumer.
