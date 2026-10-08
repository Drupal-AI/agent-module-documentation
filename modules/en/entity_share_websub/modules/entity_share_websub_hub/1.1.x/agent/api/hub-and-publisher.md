<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hub: services, endpoint, notification flow

## Services

| Service id | Class | Role |
|---|---|---|
| `entity_share_websub_hub.subscription` | `Subscription` | CRUD on the `entity_share_websub_hub_subscription` table; `save()`, `verifySubscription()`, `getSubscribersBySids()`, `checkSubscriptions($entity)`, `updateSubscriptions()`, `getUpdates()`, `unflagSubscriptions()`. |
| `entity_share_websub_hub.hub` | `Hub` (`HubInterface`) | Queues and delivers notifications; `notify(array $sids)`, `cancel(array $sids)`, `processUpdates()`, `doNotify()`, `doCancel()`, `validateIntent()`. Uses `SignatureTrait`. |
| `entity_share_websub_hub.publisher` | `Publisher` (`PublisherInterface`) | Bridges entity hooks to the hub; `notifyRelevant($entity)`, `disableSubscriptionsFor($entity)`. |
| `entity_share_websub_hub.notification_processor` | `NotificationProcessor` | Event subscriber on `KernelEvents::TERMINATE` → calls `hub->processUpdates()`. |

## The subscribe endpoint

```
POST /subscribe        route: entity_share_websub_hub.subscription_controller_subscribe
requirement: _permission 'access content'
```

Form params read by `SubscriptionController::subscribe()`: `hub_topic` (channel/uuid),
`hub_mode` (`subscribe`|`unsubscribe`), `hub_callback` (subscriber URL), `hub_secret`,
`email`. On a new record the hub calls `validateIntent()`, which GETs the callback with a
random `hub.challenge` (+ `X-Hub-Signature`); if the callback echoes the challenge the
subscription is verified (`202`), otherwise it is deleted (`403`).

## What triggers a notification

`entity_share_websub_hub.module`:
- `hook_entity_update($entity)` — for a `NodeInterface` default revision: if published →
  `publisher->notifyRelevant()`, else `publisher->disableSubscriptionsFor()`. For other
  fieldable entities: notify when it has no `status` field or `status == 1`, else disable.
- `hook_entity_delete($entity)` — always `publisher->disableSubscriptionsFor()`.

`notifyRelevant()` only acts if `checkSubscriptions($entity)` finds active subscriptions; it
writes a `content_summary` (`title : bundle`) and `uid` onto them, then `hub->notify($sids)`.

## Queue + delivery

`Hub` uses one queue, `entity_share_websub` (`QUEUE_NAME`). `notify()`/`cancel()` resolve
subscriber callback URLs and `createItem(['path' => $url])` (cancels add `'action' => 'cancel'`).
`NotificationProcessor` runs `processUpdates()` on `kernel.terminate`: it claims items until an
execution-time budget (`max_execution_time - 5`) elapses, calling:
- `doNotify()` → `httpClient->put($subscriber, ['body' => $payload, 'headers' => ['X-Hub-Signature' => getSignature($payload,$secret)]])`
- `doCancel()`  → `httpClient->delete($subscriber, ['query' => ['topic'=>$payload,'timestamp'=>time()], 'headers' => ['X-Hub-Signature' => ...]])`

`sleep(PAUSE_DURATION=3)` between items; `SuspendQueueException` releases the item and stops;
other exceptions are logged and the item dropped. `LEASE_SECONDS = 60*60*24*14` (14 days).

## Subscription table

`entity_share_websub_hub_subscription` (see the module's `.install`): `sid`,
`subscriber_endpoint` (unique key), `user_email`, `entity_type`, `entity_id` (holds the
content UUID), `status`, `update_flag`, `is_verified`, `subscriber_secret`, `content_summary`,
`uid`, `channel_id`.
Read it in Views via the shipped **Syndicated content** view (`views.view.syndicated_content`).
