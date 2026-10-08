AI Integration - ECA: Automators wires the AI Automators module to ECA in both directions: an ECA action that triggers a predefined AI Automator on an entity, and an AI Automator processor (`eca`) that runs an automator rule through ECA.

---

The submodule provides two plugins. `eca_ai_automator` (`src/Plugin/Action/AiAutomatorRule.php`, ECA `@Action`, `type = "entity"`) — the **AI Automator Trigger** action — loads a chosen `ai_automator` config entity (only those with `worker_type == 'eca'` are listed), verifies its `entity_type`/`bundle` match the ECA-supplied entity, resolves the target field definition, instantiates the automator rule, and runs `ai_automator.rule_runner->generateResponse()` to populate the field; options are `automator` (which rule), `overwrite` (regenerate even if the field is non-empty, else only when empty per `checkIfEmpty`), and `save_entity` (save the entity afterwards). `EcaProcessing` (`src/Plugin/AiAutomatorProcess/EcaProcessing.php`, `#[AiAutomatorProcessRule(id:'eca')]`) — the **ECA** processor — registers `eca` as an AI Automator worker/process type so an automator can be driven from an ECA process instead of the default runner. Together they let AI-field-interpolation automators and ECA workflows invoke each other. Depends on `ai_integration_eca`, `ai_automators`, `eca_content`. Configured only inside ECA models / AI Automator config (admin-gated); no routes, permissions, or Drush of its own.

---

- Trigger a predefined AI Automator field-generation rule from an ECA action.
- Populate an entity field with AI output as part of an ECA workflow.
- Regenerate a field's AI value on every save (overwrite) via ECA control.
- Only generate an AI field value when it is currently empty (default).
- Save the entity automatically after the automator runs, from within ECA.
- Register `eca` as an AI Automator worker type so automators run through ECA.
- Give ECA full control over when AI field interpolation happens.
- Combine AI Automators with ECA events/conditions (e.g. only on certain content states).
- Restrict AI automator triggering to a matching entity type + bundle (guarded by the action).
- Choose among only the ECA-worker automators in the action's select list.
- Bridge the AI Automators UI-driven field rules with event-driven ECA logic.
- Run AI enrichment on entity save conditionally based on ECA conditions.
- Use AI Automator rules as reusable building blocks inside larger ECA models.
- Avoid custom code to connect AI field automation with workflow events.
- Let editors configure AI field rules in Automators while devs orchestrate them in ECA.
