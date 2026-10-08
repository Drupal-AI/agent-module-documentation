<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crux — rate-limit events

`src/Event/CruxEvents.php` defines two event names, dispatched by `CruxMentionSubscriber` when a
mention is dropped because a daily limit is already reached (the queue item is NOT created):

| Constant | Event name | Event object |
|----------|------------|--------------|
| `CruxEvents::GLOBAL_DAILY_LIMIT_EXCEEDED` | `crux.global_daily_limit_exceeded` | `CruxGlobalDailyLimitExceededEvent` |
| `CruxEvents::USER_DAILY_LIMIT_EXCEEDED` | `crux.user_daily_limit_exceeded` | `CruxUserDailyMentionLimitExceededEvent` |

## Event objects
`CruxGlobalDailyLimitExceededEvent` (extends `Symfony\Contracts\EventDispatcher\Event`):
- `getLimit(): int` — configured `global_daily_limit`.
- `getCount(): int` — current count when exceeded.
- `getSourceEntity(): ?EntityInterface` — the entity where the blocked mention occurred.

`CruxUserDailyMentionLimitExceededEvent` adds `getUserId(): int` (the content author whose per-user
limit was hit), plus `getLimit()`, `getCount()`, `getSourceEntity()`.

## Subscribing
Register an `EventSubscriberInterface` (or `hook_event_dispatcher`-style listener) on the event
names above to, e.g., notify an admin, log to an external system, or surface a message. Both events
fire only when the corresponding limit is > 0 and already met; setting a limit to 0 disables it (no
event). The subscriber logs a `notice` on the `crux` channel in the same branch.
