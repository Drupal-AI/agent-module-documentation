<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `state_change` Action plugin

The module does **not** define a new plugin type; it provides one core **Action** plugin
(`@Action` id `state_change`) with a deriver, plus the `action` config entities that instantiate
its derivatives.

## Plugin + deriver

- `src/Plugin/Action/StateChange.php` — `@Action(id = "state_change", deriver =
  "…\Plugin\Deriver\StateChangeDeriver")`. `final class StateChange extends ActionBase`.
- `src/Plugin/Deriver/StateChangeDeriver.php` — `getDerivativeDefinitions()` loops every
  **moderated entity type** (`ModerationInformation::selectRevisionableEntities()`) × every
  `moderation_state` config entity, producing a derivative per pair:
  - key: `"<entity_type_id>__<state_id>"` (e.g. `node__archived`)
  - `type`: the entity type id (so the action applies to that entity type)
  - `state`: the target moderation state id
  - `label`: `"Set <Entity type> as <State label>"`

So the full plugin id of a derivative is `state_change:node__archived`, and the deriver
regenerates the list from current moderation states — add a Workbench Moderation state and new
derivatives become available (but existing `action` config entities are only (re)created at
install time; see below).

## Execution — `StateChange::execute($entity)`

1. If the entity is not moderatable, add a message and skip.
2. Load the **latest revision** (translation-aware via `loadLatestRevision()`).
3. Scheduler support: if the original had a NULL `publish_on` but the latest has one, clear it.
4. Set `moderation_state` to `pluginDefinition['state']`, `validate()`.
5. If there are `moderation_state` violations, show them as errors and abort.
6. Mark as default revision and `save()`.

## Access — `StateChange::access()`

Loads the latest revision, reads its current `moderation_state` as `from`, uses
`pluginDefinition['state']` as `to`, and returns
`AccessResult::allowedIf($validation->userMayTransition($from, $to, $account))` — where
`$validation` is `workbench_moderation.state_transition_validation`. Thus a user only sees/runs a
state action for transitions they are permitted to make.

## Creating an action config entity for a derivative

An `action` config entity that instantiates a derivative looks like:

```php
use Drupal\system\Entity\Action;
Action::create([
  'id' => 'state_change__node__archived',      // ':' replaced with '__'
  'label' => 'Set Content as Archived',
  'type' => 'node',                            // the entity type id
  'plugin' => 'state_change:node__archived',   // derivative plugin id
  'configuration' => [],
])->save();
```

This is exactly what `hook_install()` does for every derivative. The config schema
`action.configuration.state_change:*` (type `action_configuration_default`) covers the empty
configuration.
