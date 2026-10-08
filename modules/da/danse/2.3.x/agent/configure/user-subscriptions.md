# User subscriptions, notifications UI & routes

How a site visitor subscribes and reads notifications, and every route/view/block/link involved.

## Routes

| Route | Path | Handler | Access |
|---|---|---|---|
| `danse.settings` | `/admin/config/system/danse` | Form `Settings` | perm `administer site configuration` |
| `danse.prune` | `/admin/config/system/danse/prune` | Form `Prune` | perm `administer site configuration` |
| `danse.subscriptions` | `/user/{user}/subscriptions` | Form `Subscriptions` | `_custom_access: danse.service::checkAccess` (own user only) |
| `danse.reports` | `/admin/reports/danse` | menu link → DANSE Events report | perm `administer site configuration` |
| `danse_content.api.subscribe` | `/api/danse/content/{entity_type}/{entity_id}/subscribe/{key}` | `Subscription::subscribe` (AJAX) | `_custom_access: …Subscription::checkAccessSubscribe` |
| `danse_content.api.unsubscribe` | `/api/danse/content/{entity_type}/{entity_id}/unsubscribe/{key}` | `Subscription::unsubscribe` (AJAX) | `_custom_access: …Subscription::checkAccessUnsubscribe` |
| `danse_webhook` (REST) | `POST /api/danse-webhook` | REST resource `danse_webhook` | `basic_auth` + perm `restful post danse_webhook` |

Links: task `danse.subscriptions` (tab on `entity.user.canonical`), menu links `danse.settings`
(under System config) and `danse.reports` (under Reports), action link `danse.prune` (on the settings
page).

## Access model (own-user scoping)

- `danse.service::checkAccess($user, $ignoreConfig)` allows only when the account is authenticated,
  the relevant tab is enabled (or `$ignoreConfig`), **and `$user->id() === currentUser->id()`**.
  `checkAccessInt($uid)` wraps it for views.
- The user-notifications view uses the custom views access plugin **`danse_own_user`**
  (`Drupal\danse\Plugin\views\access\OwnUser`), which sets `_custom_access` to
  `danse.service::checkAccessInt` and carries a `uid` contextual filter, so a user only ever sees their
  own notifications.
- Subscribe/unsubscribe write to `user.data` under the **current** user's id only — a user cannot alter
  another user's subscriptions.
- Admin reports/notifications views require `administer site configuration`.

## Subscription storage

Subscriptions live in the **`user.data`** store: module `danse`, `name` = subscription key, value `0`
or `1`. Key format = `<pluginId>-<part>-<part>-…` (built by `PluginInterface::subscriptionKey()`).
For `content`: `content-<entityType>-<bundleOrId>-<mode>-<topic>` where `mode` is
`0` = entity type, `1` = individual entity, `2` = related (referenced) entity
(`SubscriptionOperation::SUBSCRIPTION_MODE_*`). Read/write with
`\Drupal::service('user.data')->get('danse', $uid, $key)` / `->set(...)`.

## Subscribe widget (danse_content)

`hook_entity_extra_field_info` exposes a `danse_subscribe` display component on bundles that have any
subscription role configured; `hook_entity_view` renders it via `danse_content.service::widget()`
(theme `danse_content_subscription_wrapper`, library `danse/widget`). The widget links use
`use-ajax` and hit the subscribe/unsubscribe routes; the controller's `checkAccess()` verifies:
the entity exists **and the current user has `view` access to it**, the subscription key is valid, the
current user's role is permitted for that key (`assertSubscriptionKey()`), the key entity matches the
URL entity, and the desired state differs from the current one. The response is an `AjaxResponse`
`ReplaceCommand` re-rendering the widget.

## Views (config/optional)

| View | Display / access | Purpose |
|---|---|---|
| `danse_user_notifications` | page + `block_1` block, access `danse_own_user`, `uid` arg | Current user's notifications; the block is placed as `views_block__danse_user_notifications_block_1`. |
| `danse_events` | perm `administer site configuration` | Admin audit log of all events (report at `/admin/reports/danse`). |
| `danse_notifications` | perm `administer site configuration` | Admin list of notifications. |
| `danse_notification_actions` | perm `administer site configuration` | Admin list of notification actions (delivery attempts). |
| `danse_subscriptions_nodes` / `_comments` / `_terms` | tagged `DANSE Subscription` | Embedded into the user profile as "active subscriptions" (loaded by tag in `buildUserSubscriptionForm`). |

Custom views handlers: access `danse_own_user`; fields `danse_event_label`, `danse_event_reference`
(base), `danse_subscription` (content); filter `danse_subscription` (content).

Marking read: viewing an entity in `full` view mode, or visiting `/danse/event/{danse_event}`, marks
the current user's matching notifications `seen` (see [../api/entities.md](../api/entities.md)).
