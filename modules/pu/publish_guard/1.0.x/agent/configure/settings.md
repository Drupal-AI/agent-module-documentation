<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Publish Guard — configuration & enforcement model

Settings (`publish_guard.settings`, form `Drupal\publish_guard\Form\SettingsForm`):
- `enabled` (bool) — master switch; when false `isPublishingAllowed()` returns TRUE.
- `allowed_days` — array of ints, 0=Sunday … 6=Saturday.
- `allowed_start_time` / `allowed_end_time` — `H:i` strings (default 09:00 / 17:00). Compared as strings (safe for `H:i`).
- `strictness` — `warn` or `block`.
- `message` — custom restriction text.

## Enforcement path
1. `hook_form_node_form_alter()` runs on the node add/edit form. If the user has `bypass publish guard`, it returns immediately.
2. `PublishGuardChecker::isPublishingAllowed()` checks day membership then the time window (site default timezone from `system.date`).
3. warn mode: injects a `messages--warning` inline template. block mode: appends `publish_guard_node_form_validate`, which calls `$form_state->setErrorByName('status', …)` when `status.value` is truthy.

## What it does NOT cover (verified)
- No `hook_entity_access` / `hook_ENTITY_TYPE_presave` — viewing is unaffected and programmatic `$node->setPublished()->save()` is unaffected.
- REST / JSON:API / migrate / Scheduler-driven publishes bypass the guard.
- Only the node form; other publishable entity types have no guard.

Treat it as a UI convenience, not a security boundary.
