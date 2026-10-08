# The Automators ↔ ECA plugins

## ECA action: `eca_ai_automator` ("AI Automator Trigger")

`src/Plugin/Action/AiAutomatorRule.php` — an ECA `@Action` with `type = "entity"`. Add it in an
ECA model on an entity event; it runs a predefined AI Automator rule against the event's entity.

Config:

| Field | Key | Notes |
|---|---|---|
| Automator | `automator` | Select of `ai_automator` config entities whose `worker_type == 'eca'` (label + `entity_type/bundle`). Required. |
| Overwrite existing content | `overwrite` | If on, regenerate the field on every run; if off, only when the field is empty (`$rule->checkIfEmpty()`). |
| Save entity after interpolation | `save_entity` | If on, the action saves the entity after generating the value. |

`execute($entity)`:
1. Loads the `ai_automator` entity by `automator` id (throws if missing).
2. Verifies `$entity->getEntityTypeId()` / `bundle()` match the automator's `entity_type` /
   `bundle` (throws `InvalidArgumentException` otherwise) — the guard that keeps a rule bound to its
   intended content.
3. Resolves the field definition, instantiates the automator rule
   (`plugin.manager.ai_automator`), strips the `plugin_config` key prefix, and calls
   `ai_automator.rule_runner->generateResponse($entity, $fieldDefinition, $config)` when `overwrite`
   or the field is empty.
4. Saves the entity if `save_entity`.

## AI Automator process rule: `eca`

`src/Plugin/AiAutomatorProcess/EcaProcessing.php`
(`#[AiAutomatorProcessRule(id:'eca', title:'ECA')]`, implements
`AiAutomatorFieldProcessInterface`). Registers **ECA** as an AI Automator *process/worker type* —
choose it on an automator so the rule is driven through ECA ("You need to set it up in ECA after
setting it up here") rather than the default automator runner. Constructed with
`ai_automator.rule_runner`, the logger factory, and the module handler.

Both plugins are configured through the ECA modeller and the AI Automators admin UI respectively;
there are no dedicated routes, permissions, or Drush commands in this submodule.
