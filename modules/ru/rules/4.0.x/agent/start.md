# rules — agent start

Reaction Rules = event → conditions → actions, no code. A generic event subscriber listens on
the Drupal event dispatcher; when a configured **event** fires it evaluates the rule's
**conditions** and, if they pass, runs its **actions**. Rules are `rules_reaction_rule` config
entities; reusable logic is a `rules_component` entity. Built on an **expression** engine and the
**typed_data** module (required dep). UI: **Admin → Config → Workflow → Rules**
(`/admin/config/workflow/rules`); configure route `entity.rules_reaction_rule.collection`.

- Create/manage reaction rules, components & settings (UI, routes, config) → [configure/rules.md](configure/rules.md)
- Plugin types (RulesAction, Condition, RulesEvent, RulesExpression, RulesDataProcessor) + adding an action/condition → [plugins/rules.md](plugins/rules.md)
- Build & execute rules/components in code (expression engine, RulesComponent, managers) → [api/rules.md](api/rules.md)
- Hooks, alter hooks, and defining events → [hooks/rules.md](hooks/rules.md)
- Permissions & Drush: see the Permissions and Drush sections in configure/rules.md
