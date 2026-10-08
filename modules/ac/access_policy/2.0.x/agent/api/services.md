# Public services / API

Declared in `access_policy.services.yml`. The most useful for integrators:

| Service id | Class | What it does |
|------------|-------|--------------|
| `access_policy.validator` | `AccessPolicyValidator` (`AccessPolicyValidatorInterface`) | Evaluates whether an account passes the policies on an entity for an operation |
| `access_policy.selection` | `AccessPolicySelection` (`AccessPolicySelectionInterface`) | Which policies a user may assign / are applicable; assignment gating |
| `access_policy.information` | `AccessPolicyInformation` | Is an entity/entity-type access-controlled; enabled policies per type |
| `access_policy.content_policy_manager` | `ContentAccessPolicyManager` | Get/set/assign/remove the policies on a content entity |
| `access_policy.discovery` | `AccessPolicyDiscovery` (`AccessPolicyDiscoveryInterface`) | Discover allowed/applicable policies for an entity + account |
| `access_policy.entity_type_settings` | `EntityTypeSettings` (`EntityTypeSettingsInterface`) | Load per-entity-type `access_policy.settings` |
| `access_policy.access_policy_data` | `AccessPolicyData` (`AccessPolicyDataInterface`) | Cached `hook_access_policy_data` result |
| `plugin.manager.access_policy.access_rule` | `AccessPolicyHandlerManager` | Access-rule plugins; `getHandler()`, `getApplicableHandlers()`, `getHandlersFromPolicies()` |

## Common calls

```php
$entity = \Drupal::entityTypeManager()->getStorage('node')->load(123);

// Which policies are assigned to this entity?
$policies = \Drupal::service('access_policy.content_policy_manager')->getAccessPolicy($entity);

// Does this account pass the policies for an operation? (TRUE = pass)
$ok = \Drupal::service('access_policy.validator')
  ->validate($entity, \Drupal::currentUser(), 'view');

// Is this entity under access-policy control at all?
$controlled = \Drupal::service('access_policy.information')->isAccessControlledEntity($entity);

// Programmatically assign a policy (validates it is enabled for the entity type, then saves).
$policy = \Drupal\access_policy\Entity\AccessPolicy::load('department');
\Drupal::service('access_policy.content_policy_manager')->assign($entity, $policy);
```

## Notes

- Prefer the normal `$entity->access($op, $account, TRUE)` (which triggers this module's
  `hook_entity_access`) over calling the validator directly when you want the merged core + policy
  decision. The validator returns only the module's own pass/fail.
- `AccessPolicyValidator::validate()` returns TRUE when **no** policy is assigned (the module does
  not restrict un-policied entities) and when **any** assigned policy passes.
- `AccessPolicyValidator::getViolations($entity)` / `getCacheContexts($entity)` expose the
  human-readable failure reasons and the cache contexts the module attaches to its access results.
- A `cache_context.user.field_values` cache context and `user_field_values_hash_generator` service
  let access results vary by the current user's observed field values (for ABAC field-match rules).
