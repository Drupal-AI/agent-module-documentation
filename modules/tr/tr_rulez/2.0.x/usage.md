<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rules Essentials (`tr_rulez`) is an add-on for the Rules module. It supplies Rules plugins that were never ported from Drupal 7 — extra Conditions, Actions, Events, a Condition set (XOR) expression, and two TypedData filters — plus an optional improved Rules UI that adds a "clone" button for reaction rules and components. Two submodules ship with it: `rules_examples` (working example rules for learning) and `rules_scheduler` (a partial port of the D7 scheduler).

---

Rules is Drupal's classic event–condition–action automation engine, and its Drupal 8+ rebuild arrived missing many building blocks that D7 site builders relied on. `tr_rulez` fills those gaps by registering additional Rules plugins directly into the Rules plugin managers, so they appear in the normal Rules UI alongside core Rules elements. It adds **Conditions** — `rules_flood_is_allowed` (rate-limit gate via the core flood service), `rules_path_contains_text`, `rules_path_text_comparison` (contains/starts/ends/regex on the current path), and `rules_site_is_in_maintenance_mode`; **Actions** — `rules_cache_tag_invalidator` (invalidate cache tags from a rule), `rules_flood_register_event`, and `rules_flood_clear_event`; **Events** — `tr_rulez.user_was_blocked`, `tr_rulez.user_was_unblocked`, `tr_rulez.entity_bundle_create`, and `tr_rulez.entity_bundle_delete`, dispatched from module hooks; a **`rules_xor` expression** (Condition set XOR, true when an odd number of member conditions are true); and two **TypedData filters** — `link` (turns a URI into an HTML anchor) and `raw` (marks an admin-XSS-filtered string as safe so it is not double-encoded), usable in Rules token replacements. It also overrides the core `rules_rule` expression so that a *disabled* reaction rule is skipped at evaluation time. The **improved UI** is controlled by `tr_rulez.settings:ui_choice` (default `1` = improved; `0` = stock Rules UI), exposed as a radio set on the Rules settings form (`/admin/config/workflow/rules/settings`); when on, it swaps in replacement list builders and a reworked reaction-rule edit form and enables clone routes at `…/rules/reactions/clone/{id}` and `…/rules/components/clone/{id}`. Those clone routes are correctly hardened: `_permission: 'administer rules+administer rules reactions'` requires **both** permissions and `_csrf_token: 'TRUE'` protects the state-changing GET. `rules_examples` ships ~25 disabled reaction-rule configs under `config/optional/` as living documentation. `rules_scheduler` is a **work-in-progress** port: it defines a `rules_scheduler_schedule` / `rules_scheduler_delete` action pair, a custom `Task` object backed by a `rules_scheduler` DB table, a `rules_scheduler_tasks` cron queue with a `TaskWorker`, an admin schedule page, and a Drush command (`rules:scheduler-tasks` / `rusch`) — but in 2.0.0 the core execution path is incomplete (the schedule action's `doExecute()`, the task handler's `runTask()`, and the schedule form are stubbed), so end-to-end scheduling does not yet function; treat it as scaffolding. Version **2.0.0** (2024) targets `^10.3 || ^11` and its composer requires `drupal/rules:4.0.x-dev`. Strategic note for agents: for **new** automation work the actively-developed alternative is **ECA**; `tr_rulez` is most valuable when an existing Rules deployment (often a D7 migration) needs the missing pieces.

---

- Rate-limit a rule with a flood condition (allow N events per time window per user/IP).
- Register a flood event from within a rule after a sensitive action.
- Clear a flood event for the current visitor from a rule.
- Invalidate specific cache tags as a Rules action.
- Branch a rule on whether the current path contains a substring.
- Match the current path with starts-with / ends-with / regex comparison.
- Fire a rule only while the site is in maintenance mode.
- React to a user being blocked or unblocked.
- React to a new entity bundle (content type, vocabulary, etc.) being created or deleted.
- Combine conditions with exclusive-or (XOR) semantics via `rules_xor`.
- Render a stored URI as a clickable HTML link inside a Rules message using the `link` filter.
- Emit pre-sanitized markup in a Rules token without double-encoding using the `raw` filter.
- Skip a reaction rule automatically when it is disabled (overridden `rules_rule`).
- Clone an existing reaction rule to build many near-identical rules quickly.
- Duplicate a reusable Rules component.
- Toggle between the improved UI and stock Rules UI from the settings form.
- Learn Rules by importing and enabling the shipped `rules_examples` configurations.
- Use example rules as templates for auto-generating path aliases, redirect-on-login, role assignment, etc.
- List available field-type plugins from the CLI with `drush typed-data:fields` (alias `field-list`).
- Migrate D6/D7 `rules_*` variables into `rules.settings` during upgrade.
- See which Rules UI features are unimplemented via the `/unimplemented-feature/...` modal.
- Extend an existing Rules install with conditions/actions absent from core Rules.
- Keep a Drupal 7 Rules automation model working after migration.
- Scaffold a scheduled-task workflow with `rules_scheduler` (understanding it is not yet complete).
