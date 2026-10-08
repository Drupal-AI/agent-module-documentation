<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscriber: services, routes, events, flow

## Services

| Service id | Class | Role |
|---|---|---|
| `entity_share_websub_subscriber.subscriber` | `Subscriber` | Talks to the hub; `subscribe()`/`unsubscribe()` POST `hub_topic`, `hub_mode`, `hub_callback`, `hub_secret`, `hub_verify=sync`, `email` to `<remote.url><subscribe_hub_url>`. Static `getSecret()` (HMAC of remote_id/channel_id/uuid + hash salt) and `generateSubscriptionKey()`. |
| `entity_share_websub_subscriber.subscription_manager` | `SubscriptionManager` | Local subscription state machine; `subscribe()/unsubscribe()` return whether the hub must be notified; `getStatusLabel()`. Dispatches `ContentSyncEvent`/`UnsubscribeEvent`. |
| `entity_share_websub_subscriber.subscription_repository` | `SubscriptionRepository` | CRUD on `entity_share_subscription`; `loadBySubscriptionKey()`, `loadSubscriptionsByChannel()`, `loadSubscriptionByEntity()`. |
| `entity_share_websub_subscriber.subscription_record_repository` | `SubscriptionRecordRepository` | CRUD on `entity_share_subscription_record` (imported-entity log). |
| `entity_share_websub_subscriber.hub_notifier` | `EventSubscriber\HubNotifier` | Event subscriber; queues subscribe/unsubscribe notifications to the hub. |
| `entity_share_websub_subscriber.item_import` | `EventSubscriber\ItemImport` | Event subscriber; queues the actual content import on `ContentSyncEvent`. |

Queue workers: `SubscriberWorker`, `SubscriptionRecordWorker` (in `src/Plugin/QueueWorker`).

## Callback routes (hub → this site)

All at path `/subscription/{subscription_key}`, `_access: 'TRUE'`, `no_cache: TRUE`
(`SubscriptionController`):

| Route | Method | Handler | Purpose |
|---|---|---|---|
| `entity_share_websub_subscriber.verify` | GET | `handleVerification` | Validate the hub's intent challenge (checks `hub_mode`, `hub_topic`, `hub_challenge`, `hub_lease_seconds`, and `X-Hub-Signature`); on success mark verified, dispatch `ContentSyncEvent`, echo the challenge. |
| `entity_share_websub_subscriber.update` | POST, PUT | `handleUpdateNotification` | If body `X-Hub-Signature` matches, dispatch `ContentSyncEvent` (→ import). Always returns `202` to avoid brute-force probing. |
| `entity_share_websub_subscriber.delete` | DELETE | `handleDeleteNotification` | If the `topic` query signature matches, set the subscription Cancelled and dispatch `SubscriptionDeleteEvent`. Always `202`. |

Admin route: `entity_share_websub_subscriber.cancel_subscription` at
`/entity-share/cancel-subscription/{id}` (permission `entity_share_client_pull_content`) —
the `CancelSubscriptionForm` used by the "break subscription on edit" flow.

## Pull-form integration (`.module`)

`hook_form_entity_share_client_pull_form_alter()` adds Subscribe (primary) and Unsubscribe
(secondary) buttons to the pull form's top/bottom action groups, optionally removes the
`synchronize` button when `hide_default_button` is set, and rewrites each row's status cell
from live subscription records. Submitting batches
`BatchHelper::processItem($remote,$channel,$uuid,$mode)` per selected UUID.
`hook_form_alter()` implements the `break_subscription_on_edit` redirect.

## Subscription status constants (`Subscriber`)

`SUBSCRIPTION_NOT_VERIFIED = 2`, `SUBSCRIPTION_VERIFIED = 1`, `SUBSCRIPTION_CANCELLED = 0`;
modes `MODE_SUBSCRIBE`/`MODE_UNSUBSCRIBE`; verify modes `sync`/`async`.

## Events to subscribe to

- `ContentSyncEvent::EVENT_SYNC` — a (re)import should happen for a subscription.
- `UnsubscribeEvent::EVENT_NAME` — a local unsubscribe occurred.
- `SubscriptionDeleteEvent::EVENT_NAME` — the hub cancelled a subscription.
