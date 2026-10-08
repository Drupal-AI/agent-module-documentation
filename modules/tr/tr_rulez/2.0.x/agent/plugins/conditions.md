<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditions added by tr_rulez

Source: `src/Plugin/Condition/`. All extend `Drupal\rules\Core\RulesConditionBase` and register via both the legacy `@Condition` annotation and the PHP `#[Condition]` attribute, so they appear in the Rules condition list. Verified registered on a running site.

## `rules_flood_is_allowed` — "Flood event is allowed" (category: System)
`FloodIsAllowed.php`. Wraps the core `flood` service `isAllowed()`. Returns TRUE while the visitor is still under the rate limit.

Context:
- `name` (string, required) — unique flood event name.
- `threshold` (integer, required) — max times per window.
- `window` (integer, optional, default `3600`) — seconds in the window.
- `identifier` (string, optional, default NULL) — unique visitor id; defaults to the client IP.

`doEvaluate($name, $threshold, $window = 3600, $identifier = NULL)` → `flood->isAllowed(...)`.

## `rules_path_contains_text` — "Path contains text" (category: Path)
`PathContainsText.php`. TRUE if the current internal path (`path.current` → `getPath()`) contains the given substring (`mb_strpos !== FALSE`).

Context: `text` (string, required) — substring to search for.

## `rules_path_text_comparison` — "Path text comparison" (category: Path)
`PathTextComparison.php`. Richer version of the above with an operator.

Context:
- `operator` (string, required, default `contains`) — one of `contains`, `starts`, `ends`, `regex`; options from `\Drupal\rules\TypedData\Options\ComparisonOperatorTextOptions`.
- `match` (string, required) — text/pattern. For `regex`, supply the pattern WITHOUT delimiters; the code wraps it as `'/' . str_replace('/', '\\/', $match) . '/'` and runs `preg_match` against the current path.

`doEvaluate()` switch: `starts` → `mb_strpos === 0`; `ends` → `mb_strrpos` at the tail; `regex` → `preg_match`; default → `contains`.

## `rules_site_is_in_maintenance_mode` — "Site is in maintenance mode" (category: System)
`SiteIsInMaintenanceMode.php`. TRUE when `state->get('system.maintenance_mode')` is set. No context parameters.

## Notes for agents
- The `@todo Add access callback information from Drupal 7` comments on the Path/maintenance conditions are leftovers; there is no per-condition access gating — access is the Rules UI/permission layer's job, and these conditions only *read* state, so they are side-effect-free.
- All condition config (patterns, thresholds, event names) is authored by a user with `administer rules`; treat regex/`match` values as admin-trusted (they are compiled into `preg_match`).
