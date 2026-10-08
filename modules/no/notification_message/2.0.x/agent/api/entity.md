<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity & block API

## `notification_message` entity (`src/Entity/NotificationMessage.php`)

ContentEntityType, base table `notification_message`, data table
`notification_message_field_data`, translatable, bundle entity `notification_message_type`.
Canonical link `/notification/{notification_message}`; admin collection
`/admin/content/notification-message`.

Key methods (interface `NotificationMessageInterface`):

- `isPublished(): bool` — **the core logic**: `now >= publish_start_date && now <=
  publish_end_date`. There is no stored status; `setPublished()`/`setUnpublished()` are
  intentional no-ops that just return `$this`.
- `getAuthorUser(): ?EntityInterface` — the `uid` reference (defaults to the current user via
  `getCurrentUserId()`).
- `getPublishStartDate()/getPublishEndDate()` (protected) and
  `getPublishStartDateFormat($f)/getPublishEndDateFormat($f)` — dates are stored UTC and
  formatted in the site default timezone.
- Conditions: `getConditions()`, `getConfiguredConditions()`, `hasConditions()`,
  `conditionsRequired()`, `attachConditions($plugins)`, `evaluateConditions($contexts)`.

### Condition evaluation

`evaluateConditions(array $contexts)` runs each attached core Condition plugin
(`ConditionInterface` + `ContextAwarePluginInterface`) with the required contexts extracted
from the block's runtime contexts:

- No conditions → returns `TRUE`.
- All verdicts agree → returns that verdict.
- Mixed verdicts → `TRUE` only if **not** `conditionsRequired()` and at least one is TRUE
  (i.e. `conditions_required` = AND, otherwise OR). A negated condition inverts its verdict.
- A required context that is missing/empty makes that condition evaluate `FALSE`.

Conditions are only honored when the message's **type** has `allow_condition` on.

## The display block (`src/Plugin/Block/NotificationMessageBlock.php`, id `notification_message`)

`build()` → `loadMessages()`:

```
query notification_message
  ->accessCheck(FALSE)                         // then filtered manually (see below)
  ->condition('publish_end_date',   now, '>=')
  ->condition('publish_start_date', now, '<=')
  [->condition('type', <selected types>, 'IN')]  // only if block filters types
loadMultiple(); array_filter(
  fn($m) => $m->isPublished() && $m->access('view') && $m->evaluateConditions($contexts)
)
```

Runtime contexts come from `context.repository` (`loadContexts()`), keyed by unqualified
context id. Messages render through the entity view builder in the block's `display_mode`.
When any message renders, the block attaches library `notification_message/notification.dismiss`.

### Caching

- Block cache tags include `notification_message_list` plus each rendered message's tags.
- Block cache contexts include a custom **`route.entity_uuid`** context
  (`src/Cache/Context/RouteEntityUuidCacheContext.php`) so per-entity/per-route variation is
  captured.
- `notification_message_cron()` finds messages whose `publish_end_date >=` last cron run and
  invalidates their cache tags, so newly-expired messages drop out of caches promptly.

## Storage helper

`_notification_message_storage()` (in `.module`) returns the `notification_message` storage.
Custom storage class `NotificationMessageStorage`; route provider
`NotificationMessageHtmlRouteProvider` (extends core default, just sets the collection title).
