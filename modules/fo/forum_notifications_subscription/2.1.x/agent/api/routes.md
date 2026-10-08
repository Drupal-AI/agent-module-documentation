# Action-link routes, controller & the subscribe link (API)

## Routes (`forum_notifications_subscription.routing.yml`)

| Route | Path | Controller method | Requirement |
|---|---|---|---|
| `forum_notifications_subscription.action_link_subscription` | `/forum/subscription/{entity_type_id}/{entity_id}` | `ActionLinkController::subscribe` | `_permission: 'access content'` |
| `forum_notifications_subscription.action_link_unsubscription` | `/forum/unsubscription/{entity_type_id}/{entity_id}` | `ActionLinkController::unsubscribe` | `_permission: 'access content'` |

`{entity_type_id}` is `node` (a forum topic) or `taxonomy_term` (a forum container); `{entity_id}` is
that forum/topic's id (it is **not** a user id — the subscription is always recorded for the *current*
user). These are plain GET routes with no `_csrf_token` requirement.

## Controller — `Controller\ActionLinkController`

`implements ContainerInjectionInterface`; injected with `forum_notifications_subscription.frequency`,
`entity_type.manager`, `config.factory`, `current_user`.

- `subscribe($entity_type_id, $entity_id)` →
  `frequency->createNotificationFrequencyByEntity($entity_id, $entity_type_id)` then `getResponse()`.
- `unsubscribe($entity_type_id, $entity_id)` →
  `frequency->deleteNotificationFrequencyByEntityAndType($entity_id, $entity_type_id)` then
  `getResponse()`.
- `getResponse()` reloads the entity, builds a fresh link, and returns an `AjaxResponse` containing a
  `ReplaceCommand("#{$link_selector}", …)` where `$link_selector` is
  `forum-topic-subscription-{id}` (node) or `forum-main-subscription-{id}` (term). The link therefore
  toggles in place without a page reload.
- `getSubscriptionLink(ContentEntityInterface $entity, string $type, string $link_selector, …)`
  (static) builds the render array. It calls
  `frequency->currentUserHasNotificationFrequencyByEntity($entity, $type)` to decide whether to point
  at the subscribe or unsubscribe route and which label (`*_label_on` / `*_label_off`) to show. The
  link carries classes `use-ajax btn btn-primary`, attaches `core/drupal.ajax`, and applies
  `CacheableMetadata` (route context + the entity + config + current user as cache dependencies).
  Extra optional params let it be reused with injected services; falls back to `\Drupal::service()`.

## The render link / extra field

`_forum_notifications_subscription_link_build(ContentEntityInterface $entity)` (in the `.module`)
wraps `ActionLinkController::getSubscriptionLink()` in a `<div class="forum-topic-subscription-options">`
(node) or `forum-main-subscription-options` (term) and tags it with cache tag
`forum_notification_frequency_list`. It is emitted through:

- `hook_entity_extra_field_info` — declares the pseudo-field `forum_notifications_subscription`
  (label "Subscription link", weight 10) on `node.forum` display and `taxonomy_term.forums` display.
- `hook_ENTITY_TYPE_view` for `node` (bundle `forum`) and `taxonomy_term` (bundle `forums`) — adds
  the built link to `$build['forum_notifications_subscription']` **only when the display component is
  enabled** (`$display->getComponent('forum_notifications_subscription')`).

So an integrator enables the "Subscription link" component on the forum/topic display (or renders
`content.forum_notifications_subscription` in Twig) to surface the toggle.

## What subscribe/unsubscribe actually persist

Both operate on the current user only (see
[services.md](services.md) — `createNotificationFrequencyByEntity` /
`deleteNotificationFrequencyByEntityAndType` filter by `$this->currentUser->id()`). Subscribe creates
a `forum_notification_frequency` row with the display default frequency; unsubscribe loads the current
user's matching row (by `entity_id` + `user_id` + `type`) and deletes it. There is no per-request
duplicate guard in `createNotificationFrequencyByEntity`.
