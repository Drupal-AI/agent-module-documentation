# AI Integration - ECA: Automators — agent index

Two-way bridge between **AI Automators** and **ECA**: an ECA action that triggers an AI Automator
on an entity, and an AI Automator process type (`eca`) that runs a rule through ECA. Parent:
`ai_integration_eca`. Depends on `ai_automators`, `eca_content`. No routes/permissions/Drush;
configured inside ECA / AI Automator config (admin-gated).

- **The `eca_ai_automator` ECA action and the `eca` automator process plugin** →
  [configure/plugins.md](configure/plugins.md)

Key facts:
- ECA action `eca_ai_automator` ("AI Automator Trigger", `type: entity`,
  `src/Plugin/Action/AiAutomatorRule.php`): options `automator` (select of `worker_type == 'eca'`
  automators), `overwrite`, `save_entity`. Guards that the entity's type+bundle match the
  automator; runs `ai_automator.rule_runner->generateResponse()` on the target field.
- AI Automator process rule `eca` (`#[AiAutomatorProcessRule(id:'eca')]`,
  `src/Plugin/AiAutomatorProcess/EcaProcessing.php`): registers ECA as an automator worker/process
  type.
