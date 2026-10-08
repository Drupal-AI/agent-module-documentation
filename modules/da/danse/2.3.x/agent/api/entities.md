# Entities & storage

DANSE defines three `internal` content entity types (admin permission `administer site configuration`,
no per-bundle UI). They are the audit/notification backbone.

## `danse_event` (`Drupal\danse\Entity\Event`)

Base+data table `danse_event`. Canonical link `/danse/event/{danse_event}` (route
`entity.danse_event.canonical`). Access handler `EventAccess`. View builder `EventView`. `type` key =
`topic`, `status` key = `processed`.

| Field | Type | Notes |
|---|---|---|
| `plugin` | string(32) | `@Danse` plugin id that owns the event. |
| `topic` | string(32) | e.g. `create`, `update`, `publish`, `submit`, `save`. |
| `reference` | string(64) | Unique payload reference (`Payload::getEventReference()`). |
| `label` | string(255) | Human label (truncated to 250+`…` on save if longer). |
| `payload` | string_long | JSON of the payload (incl. its `class` for rehydration via `PayloadBase::fromArray`). |
| `push` | bool | Whether recipient-selection push applies. |
| `force` | bool | Force a new notification even if an undelivered one exists. |
| `silent` | bool | If set, event is created already `processed` (no notifications). |
| `processed` | bool | Set once notifications have been generated. |
| `uid` | entity_ref(user) | Actor who triggered it (`currentUser` at create). |
| `created` / `changed` | created/changed | Timestamps. |

**`EventAccess::access()`**: grants any operation only when
`danse.query->findEventNotificationsForCurrentUser($event)` is non-empty — i.e. the current user must
already have a notification for that event. Visiting the canonical route via `EventView::build()` marks
those notifications `seen` and 302-redirects to `plugin->getRedirectUrl($event)` (for `content`, the
subject entity's URL, where core then enforces the entity's own access).

## `danse_notification` (`Drupal\danse\Entity\Notification`)

Base+data table `danse_notification`. One per (event, recipient).

| Field | Type | Notes |
|---|---|---|
| `event` | entity_ref(danse_event) | Required. |
| `trigger` | string(32) | `subscription` or `push`. |
| `uid` | entity_ref(user) | Recipient. |
| `delivered` | bool | Set once pushed/delivered. |
| `seen` | bool | Set when the recipient views the subject/event. |
| `redundant` | bool | Superseded by a newer notification. |
| `successor` | entity_ref(danse_notification) | The superseding notification. |
| `created` / `changed` | created/changed | Timestamps. |

Methods: `markSeen()`, `markDelivered()`, `setSuccessor($notification)`, `uid()`, `event()`.
`postCreate()` auto-marks `delivered` when `Settings::get('danse_notification_delivery')` is `FALSE`.

## `danse_notification_action` (`Drupal\danse\Entity\NotificationAction`)

Base+data table `danse_notification_action`. Records a delivery attempt.

| Field | Type | Notes |
|---|---|---|
| `notification` | entity_ref(danse_notification) | Required. |
| `success` | bool | Delivery result. |
| `payload` | string_long | JSON details (e.g. `{"channel plugin": "…"}`); `preCreate` json-encodes arrays. |
| `created` | created | Timestamp. |

## Subscription storage (not an entity)

Subscriptions are **not** entities — they live in `user.data` (`users_data` table), module `danse`,
`name` = subscription key, value `0/1`. See
[../configure/user-subscriptions.md](../configure/user-subscriptions.md) for the key format.

## Notification creation & content access

`PluginBase::createNotification($event, $trigger, $uid)` skips a recipient when the user is missing or
blocked, or when **`$payload->hasAccess($uid)` is false** — for content that is
`$entity->access('view', $user)`. So recipients are never notified about, or shown, content they cannot
view. Duplicate suppression: if `findSimilarEventNotifications()` returns an undelivered match and the
event is not `force`, the existing notification is reused; otherwise the old one is marked `redundant`
with a `successor`.
