<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Roles — agent start

info.yml name **Content Moderation Roles** (`content_moderation_roles`), version **1.0.0-beta3**, core `^9 || ^10 || ^11`.

A **UI/query narrowing layer on top of core Content Moderation**. It does not define its own permissions or entities. Config-driven (`content_moderation_roles.settings`), it does three things for non-full-access roles:

1. **Trims the moderation-state widget** on node add/edit forms so the current user's role only sees the states allowed for that role + bundle.
2. **Restricts a "content for review" Views query** by content type, per role.
3. **Fixes sort/status display** in "My Content"-style Views when Layout Builder pending revisions exist.

Depends on core `content_moderation`, `node`, `views`, `workflows`. No `.install`, no `.permissions.yml`, no `.api.php`, no plugin types, no Drush commands.

## Layout
- `content_moderation_roles.module` — hook implementations only (no logic).
- `src/Service/WorkflowManager.php` (service `content_moderation_roles.workflow_manager`, args `@current_user`, `@database`, `@config.factory`) — all logic.
- `src/Service/WorkflowManagerInterface.php` — contract; `const CONFIG_NAME = 'content_moderation_roles.settings'`.
- `src/Form/WorkflowSettingsForm.php` — admin form (`ConfigFormBase`).
- Route `content_moderation_roles.settings` → `/admin/config/workflow/content-moderation-roles`, gated by core permission **`administer workflows`** (the module defines no permission of its own).
- `config/install/…settings.yml` defaults: `full_access_roles: [administrator]`, `restricted_states: [draft]`, empty `views_map` and `roles: {}`.

## Hooks (`.module`)
- `hook_form_node_form_alter` + `hook_form_node_layout_builder_form_alter` → `_content_moderation_roles_apply_state_filter()` → `WorkflowManager::filterModerationStates()`. Bails if the widget path `$form['moderation_state']['widget'][0]['state']['#options']` is empty or the form entity is not a `NodeInterface`.
- `hook_views_query_alter` — reads `views_map` from config; for a `sort` match tags the Sql plugin `cmr_fix_sort`; for a `review` match calls `restrictContentForReview()`. (Review entries may omit `display_id` to match any display; sort entries require an exact `view_id`+`display_id`.)
- `hook_query_cmr_fix_sort_alter` — fires on the real `SelectInterface` after `Sql::build()`; calls `fixMyContentSort()`.

## Service methods
- `filterModerationStates(array &$form, NodeInterface $node)` — if any of the user's roles is in `full_access_roles`, returns unchanged. Else resolves allowed states and **removes disallowed options** from the widget (`restrictStates()`). Never adds options — only narrows what the core widget already offered. If the node's current state is not allowed it is removed too, and `#default_value` is reset to the first remaining option.
- `restrictContentForReview(Sql $query)` — full-access → no-op. Else resolves publishable content types: `NULL` = no type filter, `[]` = adds `WHERE 1=0`, otherwise `addWhere(0, "$alias.type", $types, 'IN')` using `ensureTable('node')` for the live alias. **Node-only** (filters `node.type`).
- `fixMyContentSort(AlterableInterface $query)` — idempotent (guards on `cmr_latest_vid` alias). LEFT-joins the latest revision per nid+langcode, rewrites the `changed` ORDER BY to `COALESCE(cmr_nfr.changed, node_field_data.changed)`, and rewrites `moderation_state` SELECT field + WHERE conditions from `node_field_data` to the latest-revision join `cmr_nfr`. **Node-only**; assumes base alias `node_field_data`.

## State resolution (`resolveAllowedStates`, most-permissive role wins)
Per assigned role present in `roles` config: `role.type_overrides[bundle]` → else `role.default_states` → else `restricted_states`; union across roles. If **no** assigned role is in the matrix → `restricted_states` (fallback). Content-type resolution for review views (`resolvePublishableTypes`) compares each role's states against a baseline (intersection of all configured roles' `default_states`, or `restricted_states`); a role whose `default_states` exceed the baseline yields `NULL` (unrestricted), otherwise only content types whose `type_overrides` exceed the baseline are returned.

## Config shape (`content_moderation_roles.settings`)
- `full_access_roles: [role_id, …]`
- `restricted_states: [state_id, …]`
- `views_map.sort: [{view_id, display_id}]`, `views_map.review: [{view_id, display_id?}]`
- `roles: { role_id: { default_states: [...], type_overrides?: { bundle: [...] } } }` — schema `type: ignore` (dynamic keys; validated in the form instead).

## Relationship to core enforcement
This module only **subtracts** options / **adds** WHERE restrictions; it never grants beyond what core already permits. Core Content Moderation transition permissions (`use <workflow> transition <transition>`) remain the actual access control. The form filter applies to the node add/edit form and the Layout Builder node form; it does not itself alter the standalone moderation-form tab, JSON:API/REST, or quick edit — treat it as an editorial UX narrowing that complements, not replaces, core permissions.

Tests: `tests/src/Unit/Service/WorkflowManagerTest.php` (unit-covers all three service methods and the resolution logic).
