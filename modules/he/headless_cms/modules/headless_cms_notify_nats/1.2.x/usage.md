<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "NATS" transport to Headless CMS - Notify that publishes notification messages to a NATS.io subject.

---

Headless CMS - Notify NATS provides a message-broker delivery channel for the Notify framework. When you create a `headless_notify_transport` and choose the **NATS** plugin, you pick a preconfigured NATS client (from the `nats` contrib module) and a subject/topic prefix. Each notification produced for a consumer using this transport is published to the subject `<topic_prefix>.<message_type>` (e.g. `mysite.entity_operation`), with the message JSON (`{type, subType, params}`) as the payload. Before publishing, a `HeadlessNotifyNatsBeforeSendEvent` is dispatched so subscribers can rewrite the subject. The topic prefix is validated to NATS subject rules (letters, numbers, dashes and dots; no trailing dot). All connection, authentication and TLS handling is delegated to the selected NATS client managed by the `nats` module — this submodule only publishes. Use it when your decoupled architecture already runs a NATS server and you want low-latency pub/sub fan-out of Drupal content events to any number of subscribers.

---

- Publish Drupal content-change events to a NATS server for real-time fan-out.
- Fan one entity change out to many subscribers via NATS pub/sub.
- Drive real-time updates in decoupled frontends listening on NATS subjects.
- Namespace events per site/environment with a subject prefix.
- Route events by type using the `<prefix>.<message_type>` subject scheme.
- Trigger microservices subscribed to `entity_operation` events.
- Signal a cache-rebuild across services via the `cache_rebuild` subject.
- Reuse an existing NATS client configured in the `nats` module.
- Rewrite the NATS subject per message via `HeadlessNotifyNatsBeforeSendEvent`.
- Point different consumers at different NATS clients or prefixes.
- Integrate Drupal into an event-driven / message-bus architecture.
- Keep search indexes or edge caches in sync via NATS subscribers.
- Build incremental static regeneration keyed off NATS messages.
- Deliver notifications with lower overhead than per-consumer HTTP webhooks.
- Combine with the Webhook transport for hybrid delivery across consumers.
