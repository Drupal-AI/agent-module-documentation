# Programmatic API — build & execute rules in code

Rules is built on an **expression engine** plus the **typed_data** module. You assemble
expressions (conditions/actions) into a rule or action set, wrap it in a `RulesComponent` to
supply context, and execute it — no config entity required.

## Build and run a rule with the expression manager

```php
use Drupal\rules\Context\ContextConfig;

/** @var \Drupal\rules\Engine\ExpressionManagerInterface $expr */
$expr = \Drupal::service('plugin.manager.rules_expression');

$rule = $expr->createRule();

// Condition: node is published.
$rule->addCondition('rules_entity_is_of_bundle',
  ContextConfig::create()
    ->map('entity', 'node')
    ->setValue('type', 'node')
    ->setValue('bundle', 'article')
);

// Action: show a message.
$rule->addAction('rules_system_message',
  ContextConfig::create()->setValue('message', 'Hello from Rules')
);
```

`ExpressionManager` helpers: `createRule()`, `createActionSet()`, `createAction($id)`,
`createCondition($id)`, and generic `createInstance($plugin_id, $config)`. Expression plugin IDs:
`rules_rule`, `rules_action_set`, `rules_action`, `rules_condition`, `rules_and`, `rules_or`,
`rules_loop`.

## Execute with context — `RulesComponent`

```php
use Drupal\rules\Context\ContextDefinition;
use Drupal\rules\Engine\RulesComponent;

$component = RulesComponent::create($rule)
  ->addContextDefinition('node', ContextDefinition::create('entity:node'))
  ->setContextValue('node', $node);

$component->execute();                 // or $rule->execute() for context-free rules
```

`RulesComponent` also powers **integrity checking** (`checkIntegrity()` returns an
`IntegrityViolationList`) so you can validate a rule's data selectors before running it.

## Load / trigger saved config entities

- `rules_reaction_rule` and `rules_component` are config entities — load via
  `\Drupal::entityTypeManager()->getStorage('rules_reaction_rule')`.
- A `ReactionRuleConfig` implements `RulesTriggerableInterface`; both config entities implement
  `RulesUiComponentProviderInterface` and expose their expression via `getExpression()`.
- The `rules.component_repository` service resolves saved components (by `rules_component` id or
  by event) for execution; reaction rules are run automatically by
  `GenericEventSubscriber`, which listens on the event dispatcher and executes matching rules
  when their event fires.

## Key managers & services

- `plugin.manager.rules_expression` (`ExpressionManager`) — build expressions.
- `plugin.manager.rules_action` (`RulesActionManager`) / `Drupal\rules\Core\ConditionManager` —
  discover action/condition plugins.
- `plugin.manager.rules_event` (`RulesEventManager`) — triggerable event definitions.
- `plugin.manager.rules_data_processor` (`DataProcessorManager`) — input transformers.
- `rules.component_repository` (`RulesComponentRepository`) — resolve/execute components.
