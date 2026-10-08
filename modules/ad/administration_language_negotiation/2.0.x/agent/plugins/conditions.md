<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: admin-language negotiation conditions

The module defines its own small plugin type used by the negotiation method to decide whether
the current request is an "admin location".

## The plugin type

- Type id: `administration_language_negotiation_condition`.
- Manager service: `plugin.manager.administration_language_negotiation_condition`
  (`AdministrationLanguageNegotiationConditionManager`, extends `DefaultPluginManager`,
  implements `ExecutableManagerInterface`).
- Namespace: `Plugin/AdministrationLanguageNegotiationCondition`.
- Annotation: `@AdministrationLanguageNegotiationCondition` (`id`, `name`, `description`,
  `weight`) — extends core's `Condition` annotation.
- Interface: `AdministrationLanguageNegotiationConditionInterface` (extends
  `ConditionInterface`) with helpers `block()` (returns FALSE), `pass()` (returns TRUE),
  `getName()`, `getWeight()`, `setWeight()`, `postConfigSave()`.
- Base class: `AdministrationLanguageNegotiationConditionBase`.
- Alter hook: `hook_administration_language_negotiation_condition_info_alter()`.

## How the method uses them

In `LanguageNegotiationAdministrationLanguage::getLangcode()` the manager instantiates every
condition (passing the whole `administration_language_negotiation.negotiation` config as
configuration) and calls `execute()` → `evaluate()`. If **any** condition returns a falsy
value (i.e. it "blocked" = matched an admin location) the method returns the user's
`preferred_admin_langcode`. So a condition returns `$this->block()` (FALSE) when the current
request IS an admin location, and `$this->pass()` (TRUE) otherwise.

## Shipped plugins

| id | Name | Config key it reads | Behaviour |
|---|---|---|---|
| `paths` | Paths | `paths` | `block()` when the current path (alias-aware, prefix-aware) matches one of the configured glob patterns. |
| `admin_routes` | Admin Routes | `admin_routes` | When the boolean is on, `block()` if the current request resolves to an admin route (`router.admin_context`). |

## Implement your own

```php
namespace Drupal\MYMODULE\Plugin\AdministrationLanguageNegotiationCondition;

use Drupal\administration_language_negotiation\AdministrationLanguageNegotiationConditionBase;
use Drupal\administration_language_negotiation\AdministrationLanguageNegotiationConditionInterface;

/**
 * @AdministrationLanguageNegotiationCondition(
 *   id = "my_condition",
 *   name = @Translation("My condition"),
 *   description = @Translation("..."),
 *   weight = 0,
 * )
 */
class MyCondition extends AdministrationLanguageNegotiationConditionBase implements AdministrationLanguageNegotiationConditionInterface {
  public function evaluate() {
    return $someRequestIsAdmin ? $this->block() : $this->pass();
  }
}
```
