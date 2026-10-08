# Negotiation, entity API and custom conditions (API)

## The negotiator service — `theme_rule.negotiator`

`Theme\ThemeRuleNegotiator` implements core `ThemeNegotiatorInterface` and is registered with
`tags: [{ name: theme_negotiator, priority: 10 }]` (args `@entity_type.manager`,
`@context.repository`, `@context.handler`). Core collects all `theme_negotiator`-tagged services into
a prioritized chain (`ThemeNegotiator`); the **highest-priority negotiator whose `applies()` returns
TRUE and whose `determineActiveTheme()` returns a non-null theme wins**. Priority 10 is deliberately
low, so a rule only takes effect where no higher-priority negotiator (admin theme, AJAX form, etc.)
has already claimed the request. When a page renders in an unexpected theme, the cause is usually this
chain ordering, not the rules themselves.

### Mechanism (`src/Theme/ThemeRuleNegotiator.php`)

- `applies()` — queries `theme_rule` storage for `status = TRUE`, sorted by `weight`
  (`accessCheck(FALSE)`), loads them, and filters out any rule with **zero conditions**. Returns TRUE
  only if at least one eligible rule remains (and caches them on the service).
- `determineActiveTheme()` — iterates the eligible rules in weight order. For each rule it resolves
  every condition’s runtime contexts via `context.repository->getRuntimeContexts()` +
  `context.handler->applyContextMapping()`. If a `MissingValueContextException` is thrown while
  mapping (a required context has no value on this request), the **whole rule is skipped**
  (`continue 2`). It then calls `resolveConditions()`: every condition must pass
  (`$condition->execute()`), i.e. **AND logic**; the first rule where all pass returns
  `$rule->getTheme()`. If a `ContextException` is thrown during `execute()`, that condition’s pass
  value falls back to `$condition->isNegated()`. If no rule matches, returns `NULL` and negotiation
  falls through to the next negotiator.

## Entity API — `ThemeRuleInterface` / `Entity\ThemeRule`

`ConfigEntityBase` that also implements `EntityWithPluginCollectionInterface`.

| Method | Returns | Notes |
|---|---|---|
| `getConditions()` | `ConditionPluginCollection` | Lazily built from the `conditions` config over `plugin.manager.condition`. |
| `getConditionsConfig()` | `array` | The collection’s configuration, keyed by condition id. |
| `getCondition($instance_id)` | `ConditionInterface` | One condition plugin instance. |
| `getTheme()` | `string` | The target theme machine name. |
| `getWeight()` | `int` | Sort weight. |
| `getPluginCollections()` | `array` | `['conditions' => …]`, so core persists the plugin collection. |

### Config dependencies (`calculateDependencies` / `onDependencyRemoval`)

On save the entity adds a `theme` dependency on the selected theme and a `module` dependency on each
condition plugin’s `provider`. `onDependencyRemoval()` removes only the conditions whose provider
module is being removed (keeping the rest of the rule). Consequences worth knowing: uninstalling a
condition’s provider module strips just those conditions; **uninstalling the target theme deletes the
whole rule** (standard config-dependency cascade). Verified by
`tests/src/Kernel/ThemeRuleDependencyTest.php`.

## Add a custom condition plugin

Theme Rule defines **no plugin type** — it consumes core `Condition` plugins. To expose a new
condition, ship an ordinary core condition plugin (`Drupal\Core\Condition\ConditionPluginBase`,
`#[Condition(...)]` / `@Condition`) in `src/Plugin/Condition/`; it appears automatically as a new tab
on the rule form, provided its required contexts are satisfiable in the `theme_rule` filter context.
The form calls `getFilteredDefinitions('theme_rule', $contexts, ['theme_rule' => $entity])`, so you
can also hide or tweak conditions for this consumer via
`hook_plugin_filter_condition__theme_rule_alter(&$definitions, $extra)` — the module’s own
implementation removes `current_theme` and (non-multilingual) `language` there. The contrib
`route_condition` module is a ready example of an added condition.

A minimal test condition lives at
`tests/modules/theme_rule_test/src/Plugin/Condition/ThemeRuleTestCondition.php` (id
`theme_rule_test`, an `evaluate()` returning a state-driven boolean) and is exercised by
`tests/src/Kernel/ThemeRuleNegotiatorTest.php`, which asserts the weight-ordered, skip-disabled,
skip-empty behaviour above.

## Reading the resolved theme from code

The negotiator is stateless beyond its per-request cache; to know the active theme elsewhere use core
`\Drupal::theme()->getActiveTheme()->getName()` or `\Drupal::service('theme.manager')`. There is no
public Theme Rule API for “which rule won”.
