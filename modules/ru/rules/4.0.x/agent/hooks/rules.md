# Hooks, alter hooks & defining events

Rules ships **no `rules.api.php`**. Its own hook implementations live as OOP hook classes in
`src/Hook/` (`RulesEntityHooks`, `RulesUserHooks`, `RulesCronHooks`, `RulesMailHooks`,
`RulesPageHooks`, `RulesHelpHooks`), wired from `rules.module` via `#[LegacyHook]`. What you as an
integrator use are the plugin **alter hooks** and the **event definition** mechanism.

## Alter the plugin definitions

Each Rules plugin manager runs a discovery-alter hook, so a module can add, remove, or modify
definitions:

- `hook_rules_action_info_alter(&$definitions)` — alter available actions.
- `hook_rules_expression_info_alter(&$definitions)` — alter expression plugins.
- `hook_rules_event_info_alter(&$definitions)` — alter event definitions.
- `hook_rules_data_processor_info_alter(&$definitions)` — alter data processors.

(Conditions use core's `condition` plugin type, altered via `hook_condition_info_alter()`.)

## Define a triggerable event

Rules events are declared in a `your_module.rules.events.yml` file (discovered by
`RulesEventManager`). Minimal example:

```yaml
mymodule_widget_shipped:
  label: 'A widget has been shipped'
  category: 'Commerce'
  context_definitions:
    widget:
      type: entity:node
      label: 'The shipped widget'
    account:
      type: entity:user
      label: 'Shipping user'
```

Then dispatch it from your code (an event object exposing those context values) so reaction rules
can react. For events that need per-bundle variants, provide a `deriver` and an event handler
`class` (see the built-in entity CRUD events using `EntityPresaveDeriver` etc. and
`ConfigurableEventHandlerEntityBundle`). Simple events default to `RulesDefaultEventHandler`.

## Reacting vs. defining

To *react* to an existing event you build a reaction rule (no code) — see
[../configure/rules.md](../configure/rules.md). Code is only needed to *define a new event*, add a
*custom action/condition/data processor* (see [../plugins/rules.md](../plugins/rules.md)), or
*alter* the plugin lists above.
