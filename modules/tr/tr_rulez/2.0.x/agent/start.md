<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules Essentials (tr_rulez) — agent index

**Add-on for the Rules module. Registers extra Rules plugins (Conditions, Actions, Events, a Condition set XOR expression, and `link`/`raw` TypedData filters) that were missing from the D8+ port, plus an optional improved Rules UI with a clone operation. Ships `rules_examples` and a work-in-progress `rules_scheduler` submodule.**

- **Version:** 2.0.x (2.0.0, 2024)
- **Core:** `^10.3 || ^11` (`core_semver_minimum` 10.3.0)
- **Requires:** `rules` (composer requires `drupal/rules:4.0.x-dev`); Typed Data API comes transitively via Rules.
- **Configure:** `rules.settings` → improved-UI toggle is added to the Rules settings form at `/admin/config/workflow/rules/settings`.
- **License:** GPL-2.0-or-later.
- **Permissions provided:** none (reuses Rules' `administer rules`, `administer rules reactions`, `administer rules components`).
- **Drush:** `typed-data:fields` (alias `field-list`) lists field-type plugins; submodule adds `rules:scheduler-tasks` (alias `rusch`).

## What it actually adds to Rules

Everything is registered into the standard Rules/TypedData plugin managers, so it shows up in the normal Rules UI. Verified present on a running site with `tr_rulez` enabled.

- **Conditions** (`src/Plugin/Condition/`): `rules_flood_is_allowed`, `rules_path_contains_text`, `rules_path_text_comparison`, `rules_site_is_in_maintenance_mode`. See [plugins/conditions.md](plugins/conditions.md).
- **Actions** (`src/Plugin/RulesAction/`): `rules_cache_tag_invalidator`, `rules_flood_register_event`, `rules_flood_clear_event`. See [plugins/actions.md](plugins/actions.md).
- **Events** (`tr_rulez.rules.events.yml` + `src/Event/`): `tr_rulez.user_was_blocked`, `tr_rulez.user_was_unblocked`, `tr_rulez.entity_bundle_create`, `tr_rulez.entity_bundle_delete`, dispatched from hooks in `tr_rulez.module`. See [plugins/events.md](plugins/events.md).
- **Expressions** (`src/Plugin/RulesExpression/`): `rules_xor` (Condition set XOR); plus an override of core `rules_rule` (`RuleExpression`) that skips a *disabled* reaction rule at evaluation. See [plugins/expressions.md](plugins/expressions.md).
- **TypedData filters** (`src/Plugin/TypedDataFilter/`): `link` (URI → HTML anchor) and `raw` (admin-XSS-filtered string marked safe, no double-encoding). See [plugins/data-filters.md](plugins/data-filters.md).

## Improved UI (optional, on by default)

`tr_rulez.settings:ui_choice` defaults to `1` (improved); `0` = stock Rules UI. When `1`, `hook_entity_type_alter()` + `hook_rules_expression_info_alter()` swap in `RulesReactionListBuilder` / `RulesComponentListBuilder`, `ReactionRuleEditForm`, and enable **clone** routes. See [ui/improved-ui.md](ui/improved-ui.md).

## Submodules

- **`rules_examples`** — ~25 disabled reaction-rule configs in `rules_examples/config/optional/` as living documentation. Configure at `entity.rules_reaction_rule.collection`.
- **`rules_scheduler`** — partial D7-scheduler port: schedule/delete actions, a custom `Task` DB-table entity, a `rules_scheduler_tasks` cron queue + `TaskWorker`, an admin schedule page, and Drush. **Core execution is incomplete in 2.0.0** (schedule action `doExecute()`, `DefaultTaskHandler::runTask()`, and `ScheduleTaskForm::buildForm()` are stubbed). See [scheduler/rules-scheduler.md](scheduler/rules-scheduler.md).

## Also provides

- Drush `typed-data:fields` / `field-list` (`src/Drush/Commands/TrRulezDrushCommands.php`).
- A D6/D7 → `rules.settings` migration (`migrations/rules_settings.yml`).
- `tr_rulez_update_8101/8102` renamed the four events (old `tr_rulez_*` → `tr_rulez.*`) in stored config + state.
- `/unimplemented-feature/{feature}/{title}/{issue}` modal route that honestly names not-yet-built UI features (gated by `administer rules`).

## Security posture

No anonymous or unauthenticated surface. Every route is admin-gated (`administer rules` and friends); the state-changing clone routes additionally carry `_csrf_token: 'TRUE'` and require **two** permissions each (`administer rules+administer rules reactions`). Rules Actions/Conditions here call safe core services (flood, cache-tags invalidator, state, current-path) — no `eval`/dynamic PHP, no shell, no external HTTP. TypedData `link`/`raw` filters run values through `Xss::filterAdmin()` before marking safe. Fresh review found no exploitable finding; see the report for admin-only defense-in-depth notes.

## Strategic note

For **new** automation work the actively-developed engine is **ECA**. `tr_rulez` is most useful when an existing Rules deployment (often a D7 migration) needs the plugins the D8+ port left out.
