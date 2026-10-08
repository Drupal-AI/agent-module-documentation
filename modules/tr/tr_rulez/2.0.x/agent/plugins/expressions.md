<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules expressions added / overridden by tr_rulez

Source: `src/Plugin/RulesExpression/`. Registered via `@RulesExpression` + `#[RulesExpression]`. Verified: `rules_xor` present in the expression manager and `rules_rule` resolves to the tr_rulez override on a running site.

## `rules_xor` — "Condition set (XOR)" (new)
`XorExpression.php`, extends `Drupal\rules\Engine\ConditionExpressionContainer`. A condition-group container that evaluates its child conditions with logical XOR: it toggles a boolean each time a child condition is TRUE, so the set is TRUE when an **odd** number of children are TRUE (and FALSE for an empty set). Form class `\Drupal\tr_rulez\Form\Expression\ConditionContainerForm`. `allowsMetadataAssertions()` returns FALSE (child execution is not guaranteed, so no metadata assertions). Config schema `rules_expression.rules_xor` is defined in `config/schema/tr_rulez.schema.yml`.

This complements core Rules' AND (`rules_and`) and OR (`rules_or`) condition sets.

## `rules_rule` — "Rule" (override of core)
`RuleExpression.php` extends `Drupal\rules\Plugin\RulesExpression\RuleExpression`. It injects `entity_type.manager` and the `logger.channel.rules_debug` channel and overrides `executeWithState()` so that before evaluating conditions/actions it loads the owning `rules_reaction_rule` and checks `status = TRUE`. **If the reaction rule is disabled, the expression returns immediately without running** — fixing the situation where a disabled reaction rule could still fire. It keeps the core form class `\Drupal\rules\Form\Expression\RuleExpressionForm`.

## How the overrides are wired
`tr_rulez_rules_expression_info_alter()` (in `tr_rulez.module`) applies these ONLY when `tr_rulez.settings:ui_choice == 1` (the default improved UI):
- Sets `rules_rule` `class` to the tr_rulez `RuleExpression`.
- Sets `form_class` on `rules_action_set` / `rules_loop` to `ActionContainerForm`, and on `rules_and` / `rules_or` to `ConditionContainerForm` (tr_rulez's expression container forms in `src/Form/Expression/`).
- Adds human-readable `description` text to the core expression definitions (`rules_action`, `rules_action_set`, `rules_condition`, `rules_and`, `rules_or`, `rules_loop`).

Note: `rules_xor` itself is registered unconditionally via its plugin attribute; the `_info_alter` hook only governs the class/form/description overrides listed above. With `ui_choice == 0`, those overrides are skipped and stock Rules classes are used.
