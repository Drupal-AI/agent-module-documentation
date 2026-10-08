ActivityPub Scheduler ties federated posting to the Scheduler module: a node scheduled to publish is sent to the Fediverse at publish time and withdrawn when unpublished.

---

ActivityPub Scheduler (`activitypub_scheduler`) subscribes to the Scheduler module's node publish and unpublish events. On scheduled publish, it finds the node's outbox `activitypub_activity` records, marks them published and (re)queues them for delivery to followers through the parent module's process client. On scheduled unpublish, it unpublishes those activities so they are no longer sent. It ships a `scheduler` ActivityPub type config entity. This lets editors schedule when content federates rather than pushing it to the Fediverse immediately on save.

---

- Federate a node to the Fediverse exactly when Scheduler publishes it, not at save time.
- Queue the node's outbox ActivityPub activities for delivery on scheduled publish.
- Mark the node's ActivityPub activities published when the node goes live.
- Unpublish the node's ActivityPub activities when Scheduler unpublishes the node.
- Keep federated content in step with a node's scheduled publish/unpublish windows.
- Invalidate the author's user cache tag on publish/unpublish so timelines refresh.
- Work automatically once both Scheduler and ActivityPub are configured for the content type.
- Support editorial workflows that plan social/federated distribution in advance.
- Avoid sending posts for content that is only scheduled, not yet live.
- Reuse the parent module's outbox queue and delivery pipeline.
