<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Share Websub Hub turns a Drupal site into a WebSub-style publishing hub: it accepts subscriptions to individual content items over a `/subscribe` endpoint and pushes signed update/cancel notifications to subscriber sites whenever that content changes.

---

The Hub submodule is the publisher end of Entity Share Websub. It exposes `POST /subscribe`, where a subscriber registers a topic (a channel + entity UUID), a callback URL, a secret, and an email; the hub validates the subscriber's intent with a challenge/response handshake (`validateIntent()`), stores the subscription in the `entity_share_websub_hub_subscription` database table, and marks it verified. From then on, `hook_entity_update()` and `hook_entity_delete()` watch every fieldable entity: when a published, default-revision entity that has active subscriptions changes, the `Publisher` service flags those subscriptions and the `Hub` service queues a notification; unpublishing or deleting flags them for cancellation instead. Notifications are drained from the `entity_share_websub` queue by a `kernel.terminate` event subscriber (`NotificationProcessor`), so the editor's save request is never blocked — each subscriber is sent a signed `PUT` (update) or `DELETE` (cancel) carrying an `X-Hub-Signature` header computed with the base module's `SignatureTrait`. Subscriptions use a 14-day lease (`LEASE_SECONDS`). The module also ships a `syndicated_content` View plus custom Views field/filter plugins so an administrator with the `see content subscriptions` permission can see which sites subscribed to which content.

---

- Run the central "publisher" site that downstream Drupal sites subscribe to for automatic content updates.
- Accept per-entity subscriptions from subscriber sites over the `/subscribe` endpoint.
- Validate a new subscriber's intent with a WebSub challenge/response handshake before activating it.
- Push a signed update notification to every subscriber the moment a published node changes.
- Automatically cancel subscriptions to a piece of content when it is unpublished or deleted.
- Notify subscribers asynchronously through a queue so saving content never blocks on HTTP calls.
- Sign every outbound notification with `X-Hub-Signature` so subscribers can verify it came from this hub.
- Track all active subscriptions in the `entity_share_websub_hub_subscription` table for auditing.
- Give administrators a "Syndicated content" View listing which remote sites subscribed to which entities.
- Gate visibility of that subscription report behind the `see content subscriptions` permission.
- Support syndication of any fieldable entity type, with node-specific publish/unpublish handling.
- Enforce a 14-day subscription lease so stale subscribers eventually expire.
- Pause between subscriber notifications (`PAUSE_DURATION`) to avoid hammering downstream sites.
- Batch-process queued notifications within the request's execution-time budget, resuming next request.
- Log delivery errors per subscriber via the `entity_share_websub_hub` logger channel.
- Act as one node in a hub-and-spoke or chained content-distribution network of Drupal sites.
- Combine with Entity Share Server channels so subscribers can both pull and be pushed updates.
- Store a per-subscription secret and email so notifications and cancels are addressed and signed correctly.
- Re-notify subscribers with updated content summaries (title + bundle + author) when content is republished.
- Serve as the publishing half of a bidirectional site that is also an Entity Share Websub subscriber.
