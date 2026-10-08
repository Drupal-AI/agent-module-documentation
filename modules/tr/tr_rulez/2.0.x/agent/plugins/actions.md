<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Actions added by tr_rulez

Source: `src/Plugin/RulesAction/`. Extend `Drupal\rules\Core\RulesActionBase`; the two flood actions share `RulesFloodActionBase` (injects `flood` + the `rules` logger channel). Registered via `@RulesAction` annotation + `#[RulesAction]` attribute. Verified registered on a running site.

## `rules_cache_tag_invalidator` — "Cache tag invalidator" (category: System)
`CacheTagInvalidator.php`. Invalidates one or more cache tags from within a rule via the `cache_tags.invalidator` service; logs an info message on the `rules` channel.

Context: `cache_tags` (string, `multiple = TRUE`) — the cache tag(s) to invalidate.
`doExecute(array $cache_tags)` → `cacheTagsInvalidator->invalidateTags($cache_tags)`.

## `rules_flood_register_event` — "Register flood event" (category: System)
`FloodRegisterEvent.php`. Records a flood event for the current visitor (core `flood->register()`); logs a notice.

Context:
- `name` (string, required) — flood event name.
- `window` (integer, optional, default `3600`) — window seconds.
- `identifier` (string, optional, default NULL) — visitor id; defaults to client IP.

## `rules_flood_clear_event` — "Clear flood event" (category: System)
`FloodClearEvent.php`. Makes the flood mechanism forget an event for the current visitor (core `flood->clear()`); logs a notice.

Context:
- `name` (string, required) — flood event name.
- `identifier` (string, optional, default NULL) — visitor id; defaults to client IP.

## Pattern (flood rate-limiting with Rules)
Combine with the `rules_flood_is_allowed` condition: a reaction rule on some event checks `rules_flood_is_allowed(name, threshold, window)`; when allowed it performs its work and calls `rules_flood_register_event(name, window)`; a separate rule (e.g. on success/login) calls `rules_flood_clear_event(name)` to reset the counter. All three actions/condition share the same `name` and (optional) `identifier`.

## Notes for agents
- These actions call only core services (cache-tags invalidator, flood) — no dynamic code execution, no external I/O.
- Scheduler actions (`rules_scheduler_schedule`, `rules_scheduler_delete`) live in the `rules_scheduler` submodule — see [../scheduler/rules-scheduler.md](../scheduler/rules-scheduler.md). Note their execution path is incomplete in 2.0.0.
