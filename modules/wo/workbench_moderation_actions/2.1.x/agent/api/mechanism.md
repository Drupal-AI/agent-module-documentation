<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install/uninstall, operation links, and the state-change route

## Install / uninstall (`workbench_moderation_actions.install`)

- **`hook_install()`**:
  1. Deletes the core `action` config entities `node_publish_action` and
     `node_unpublish_action` (they misbehave under Workbench Moderation).
  2. Runs `StateChangeDeriver::getDerivativeDefinitions()` and creates one `action` config entity
     per derivative (`id` = `state_change__<type>__<state>`, `plugin` = `state_change:<type>__<state>`,
     `type` = entity type id, empty `configuration`).
- **`hook_uninstall()`**: recreates `node_publish_action` and `node_unpublish_action` by reading
  the node module's default install config (`system.action.*`) and saving them with `trustData()`.

Consequence for agents: the set of available bulk actions is fixed **at install time**. If
moderation states are added later, re-run the deriver / recreate the missing `action` entities
(or reinstall the module) to expose them. Confirm what exists:

```bash
drush php:eval 'foreach (\Drupal\system\Entity\Action::loadMultiple() as $a) {
  if (strpos((string) $a->get("plugin"), "state_change") === 0) { print $a->id()." => ".$a->get("plugin")."\n"; }
}'
```

## Bulk usage

The created actions appear in the **Action** select on `/admin/content` and in any Views Bulk
Operations list over a moderated entity type. Select rows, pick "Set <Entity> as <State>", apply.

## Per-row operation links — `hook_entity_operation()`

`workbench_moderation_actions_entity_operation()` adds, for each moderatable entity, one
operation per **valid transition target** for the current user
(`StateTransitionValidation::getValidTransitionTargets()`): title "Set to <state label>", an
AJAX (`use-ajax`) link to the `state_change` route, weight 20. It attaches the
`workbench_moderation_actions/ajax_commands` library.

## Route / controller

`workbench_moderation_actions.routing.yml` defines `workbench_moderation_actions.state_change` at
`/workbench_moderation_actions/state_change/{entity_type_id}/{entity_id}/{from}/{to}`, handled by
`Controller\StateChange::change`, guarded by `_custom_access` (`StateChange::access`) and
`_csrf_token: 'TRUE'`. This backs the per-row operation links (single-entity state change),
returning an AJAX reload command (`AjaxReloadCommand`).

## Requirement note

Depends on **Workbench Moderation** (contrib). It is unrelated to core **Content Moderation**;
a site using only core moderation will have no `moderation_state` config entities of the
Workbench kind and thus no derived actions.
