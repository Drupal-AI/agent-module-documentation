# `twig_validator_rule` plugin type

Defines a rule that inspects Twig nodes of a component template and emits validation messages.

- Manager: `plugin.manager.twig_validator_rule` (`TwigValidatorRulePluginManager`, dir
  `Plugin/TwigValidatorRule`, alter hook `twig_validator_rule_info`).
- Attribute: `#[TwigValidatorRule]` (`src/Attribute/TwigValidatorRule.php`):
  - `id` (string) — must equal the group or be prefixed `group:...` (discovery quirk noted in the
    attribute docblock).
  - `twig_node_type` (string) — the `\Twig\Node\Node` class this rule applies to.
  - `rule_on_name` (array) — name-based rules keyed by type.
  - `label`, `description` (optional `TranslatableMarkup`), `deriver` (optional).
- Interface: `TwigValidatorRuleInterface`; base class: `TwigValidatorRulePluginBase`.

## Name classification helpers (from the interface)

Rules bucket names via `getNameAllow()`, `getNameDeprecate()`, `getNameWarn()`,
`getNameForbid()`, `getNameIgnore()` (all fed from `getRulesByName()`), then `processNode(...)`
walks the matched Twig node and pushes `ValidatorMessage`s.

## Shipped rules (reference implementations in `src/Plugin/TwigValidatorRule/`)

`TwigValidatorRuleConstant`, `...Filter`, `...Function`, `...Include`, `...GetAttr`, `...Name`,
`...Node`, `...Ternary`, `...ElvisBinary`, `...NullCoalesceBinary`, `...RangeBinary`,
`...TestExpr`, `...Parent`. Copy the closest one for a new rule.

## Skeleton

```php
namespace Drupal\my_module\Plugin\TwigValidatorRule;

use Drupal\sdc_devel\Attribute\TwigValidatorRule;
use Drupal\sdc_devel\TwigValidatorRulePluginBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[TwigValidatorRule(
  id: 'my_rule',
  twig_node_type: \Twig\Node\Expression\FunctionExpression::class,
  rule_on_name: [],
  label: new TranslatableMarkup('My rule'),
)]
final class MyRule extends TwigValidatorRulePluginBase {
  // Override getRulesByName()/processNode() to classify + emit ValidatorMessage.
}
```

The validator (`TwigValidator`) parses the component template, visits nodes
(`TwigRulePluginVisitor`), and dispatches each node to the rule registered for its
`twig_node_type`.
