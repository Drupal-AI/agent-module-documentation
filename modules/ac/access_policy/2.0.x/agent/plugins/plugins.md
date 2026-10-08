# Plugin types

Access Policy defines **eight** plugin types. Custom plugins go in
`src/Plugin/access_policy/<Type>/` of your module and use the matching annotation.

| Plugin type | Annotation | Manager service | Directory | Purpose |
|-------------|-----------|-----------------|-----------|---------|
| Access rule | `@AccessRule` | `plugin.manager.access_policy.access_rule` (`AccessPolicyHandlerManager`, type `access_rule`) | `Plugin/access_policy/AccessRule` | Validate an attribute at access-check time (grant/deny) |
| Selection rule | `@SelectionRule` | `plugin.manager.access_policy.selection_rule` (`AccessPolicyHandlerManager`, type `selection_rule`) | `Plugin/access_policy/SelectionRule` | Decide which entities a policy auto-applies to (dynamic strategy) |
| Selection strategy | `@SelectionStrategy` | `plugin.manager.selection_strategy` | `Plugin/access_policy/SelectionStrategy` | How/when policies are assigned (`dynamic`, `manual`) |
| Operation | `@AccessPolicyOperation` | `plugin.manager.access_policy_operation` | `Plugin/access_policy/AccessPolicyOperation` | Bind a Drupal entity operation (view/update/delete/…) to the policy engine + its permission |
| Query | `@AccessPolicyQuery` | `plugin.manager.access_policy_query` | `Plugin/access_policy/AccessPolicyQuery` | DB query integration for listing/reference filtering (`sql`, `sql_subquery`) |
| Access rule argument | `@AccessRuleArgument` | `plugin.manager.access_rule_argument` | `Plugin/access_policy/AccessRuleArgument` | Contextual value to compare against (e.g. `current_user`) |
| Access rule widget | `@AccessRuleWidget` | `plugin.manager.access_rule_widget` | `Plugin/access_policy/AccessRuleWidget` | Render an observed field on the Access selection tab (`entity_field`) |
| 403 response | `@Http403Response` | `plugin.manager.http_403_response` | `Plugin/access_policy/Http403Response` | The access-denied behaviour (`message`) |

## Built-in access rules (illustrative)

`is_own`, `weekday_range`, `user_role_reference`, `user_field_role`, `term_reference_depth`,
`entity_field_string`, `entity_field_numeric`, `entity_field_boolean`, `entity_field_date`,
`entity_field_list`, `entity_field_list_numeric`, `entity_field_entity_reference`,
`entity_field_moderation_state`, `entity_field_empty`, `entity_field_type`, `entity_field_standard`,
`broken` (fallback). Most `EntityField*` rules support configurable operators and an
`empty_behavior` (`deny` / `ignore` / `allow`).

## Two ways to add a custom access rule

**A. Register an existing plugin against a field** (no PHP class) — implement
`hook_access_policy_data()` (see [hooks/hooks.md](../hooks/hooks.md)) to map a field to a built-in
`plugin_id`. This is the common path.

**B. A new rule plugin** — extend `AccessRuleBase` (`Plugin/access_policy/AccessRule/`) and annotate
with `@AccessRule`. Implement:

```php
namespace Drupal\mymodule\Plugin\access_policy\AccessRule;

use Drupal\access_policy\Plugin\access_policy\AccessRule\AccessRuleBase;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Session\AccountInterface;

/**
 * @AccessRule(
 *   id = "my_rule",
 *   handlers = { "query_alter" = "\Drupal\mymodule\AccessRuleQueryHandler\MyRule" }
 * )
 */
class MyRule extends AccessRuleBase {
  public function isApplicable(EntityInterface $entity) { return TRUE; }

  public function validate(EntityInterface $entity, AccountInterface $account) {
    // Return TRUE (grant), FALSE (deny / adds a violation), or NULL (skip this rule).
    return $entity->getOwnerId() == $account->id();
  }

  public function getCacheContexts() {
    // Vary the access result correctly: 'user' when comparing to the account/uid,
    // 'user.field_values' when comparing observed user fields, else 'user.permissions'.
    return ['user'];
  }
}
```

Key contract points (from `AccessPolicyValidator::validateAccessRulePlugins`): a rule returning
`NULL` is skipped; under the policy's `AND` operator any `FALSE` fails immediately; under `OR` any
`TRUE` passes immediately. Provide a `query_alter` handler
(`AccessRuleQueryHandler/*`) if the rule must also filter listing/reference queries. To also expose
the rule in the UI, register its field mapping through `hook_access_policy_data()`.
