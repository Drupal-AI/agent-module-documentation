<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Share Websub Subscriber is the subscriber end of Entity Share Websub: it adds Subscribe/Unsubscribe buttons to the Entity Share pull form, registers subscriptions with a remote hub, and automatically re-imports content when the hub notifies it that the content changed.

---

This submodule lets a Drupal site subscribe to individual content items on a remote Entity Share hub and keep them updated automatically. On the Entity Share client pull form (`entity_share_client_pull_form`) it injects **Subscribe** and **Unsubscribe** submit buttons and a live subscription-status column; selecting entities and clicking a button batches a subscribe/unsubscribe call to the hub for each UUID. Each subscription gets a generated `subscription_key` (used in a callback URL) and an HMAC `secret` (derived with the site hash salt), tracked in the `entity_share_subscription` table, with imported entities logged in `entity_share_subscription_record`. Three open callback routes at `/subscription/{subscription_key}` handle the hub's GET (verify the intent challenge), POST/PUT (update notification → import), and DELETE (cancel) requests — each authenticated by recomputing the `X-Hub-Signature` with the base module's `SignatureTrait`, not by a Drupal permission. A settings form at `/admin/config/entity-share-websub-subscriber` (permission `administer entity share websub subscriber settings`) chooses which Entity Share **import config** the automated sync uses, can hide Entity Share's default manual Sync button, can prompt editors to cancel a subscription before they locally edit imported content (with customizable dialog texts), and can override the hub's subscribe endpoint path (default `/subscribe`). Imports run through queue workers and dispatch `ContentSyncEvent`, `UnsubscribeEvent`, and `SubscriptionDeleteEvent` for other code to react to.

---

- Subscribe a client site to specific articles on a remote Entity Share hub and receive updates automatically.
- Add Subscribe/Unsubscribe buttons directly to the Entity Share content pull form.
- Show a per-row subscription status (Subscribed / Not verified / Cancelled) on the pull form.
- Choose which Entity Share import configuration the automated background sync should use.
- Hide Entity Share's default manual "Synchronize" button once automation is in place.
- Automatically re-import a subscribed entity when the hub sends an update notification.
- Verify a new subscription via the hub's challenge/response handshake before importing.
- Authenticate incoming hub callbacks with the per-subscription secret and `X-Hub-Signature`.
- Prompt editors to cancel a subscription before they locally edit imported (source-controlled) content.
- Customize the cancel-subscription dialog title, body, and button labels.
- Override the hub's subscribe endpoint path when the hub uses a non-default URL.
- Cancel (unsubscribe) selected content so it stops receiving remote updates.
- Keep a local audit of which entities were imported via `entity_share_subscription_record`.
- Batch subscribe/unsubscribe operations across many selected entities without blocking the UI.
- Dispatch `ContentSyncEvent` so custom code can post-process each automated import.
- React to `UnsubscribeEvent` / `SubscriptionDeleteEvent` to clean up or notify on subscription changes.
- Run a site that consumes syndicated content push-style instead of polling the hub on cron.
- Re-subscribe to previously cancelled content and trigger a fresh sync of the local copy.
- Gate access to the subscriber settings form with a dedicated admin permission.
- Serve as the consuming half of a bidirectional site that is also an Entity Share Websub hub.
- Restrict cancellation UX to imported content that is currently in a verified subscription state.
