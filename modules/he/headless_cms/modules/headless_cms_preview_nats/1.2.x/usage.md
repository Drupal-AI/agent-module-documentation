<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Publishes a NATS message whenever a content editor saves a headless preview, enabling real-time live-reload of node previews in a decoupled frontend.

---

Headless CMS - Preview NATS extends Headless CMS - Preview with real-time push. It subscribes to the `headless_cms_preview.preview_updated` event (fired when an editor uses Save Preview) and, when enabled, publishes a small `{operation: 'update'}` message to a NATS subject built from a configurable prefix plus the editing account id and the entity's type/bundle (`<prefix>.<uid>.<entity_type>--<bundle>`). A decoupled frontend subscribed to that subject can then reload the preview data immediately, giving editors live-reload as they save drafts. Configuration is added to the existing Headless CMS Preview settings form (`/admin/config/headless-cms/preview`) as a *NATS Settings* section: an enable toggle, the NATS client to use, and the subject prefix. All NATS connection, authentication and TLS handling is delegated to the selected client from the `nats` module; this submodule only publishes.

---

- Live-reload node previews in a decoupled frontend as editors save drafts.
- Push preview-updated events to a NATS server in real time.
- Subscribe a frontend to per-user preview update subjects.
- Scope preview updates by editor account and entity type/bundle via the subject.
- Namespace preview events per site/environment with a subject prefix.
- Enable or disable NATS preview push without code changes.
- Reuse a NATS client already configured in the `nats` module.
- Give editors instant feedback in the real frontend while editing.
- Build collaborative/real-time editorial preview experiences.
- Combine with Notify - NATS for a fully NATS-driven decoupled setup.
- Avoid polling the frontend for draft changes.
- Trigger frontend preview refreshes only for the relevant editor's session.
- Integrate Drupal preview into an event-driven frontend architecture.
- Drive websocket bridges from NATS to browser preview clients.
