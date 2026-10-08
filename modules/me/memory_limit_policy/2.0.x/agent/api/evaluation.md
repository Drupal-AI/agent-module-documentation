<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How policies are evaluated and applied

## Request flow

`MemoryLimitPolicySubscriber` (service `memory_limit_policy.subscriber`, args
`@entity_type.manager`, `@config.factory`) subscribes to:

- `KernelEvents::REQUEST` → `onRequest`, priority **-1** (runs early).
- `KernelEvents::RESPONSE` → `onResponse`.

`onRequest`:
1. Loads all policies with `status = TRUE`
   (`getStorage('memory_limit_policy')->loadByProperties(['status' => TRUE])`).
2. Sorts them by `weight` **ascending**.
3. Sets request attribute `_memory_limit_policy_override = FALSE`.
4. For each policy, if `$policy->evaluate()` is TRUE:
   `ini_set('memory_limit', $policy->getMemory());` and
   `_memory_limit_policy_override = $policy->id()`.

The loop does **not** break, so when several policies match, the **last one in weight order**
(highest weight) is the memory value that ends up applied, and its id is recorded as the
override.

## Policy-level AND with per-constraint negation

`MemoryLimitPolicy::evaluate()`:

```php
foreach ($this->getConstraints() as $constraint) {
  $plugin = \Drupal::service('plugin.manager.memory_limit_policy.memory_limit_constraint')
    ->createInstance($constraint['id'], $constraint);
  if ($constraint->isNegated() ? $constraint->evaluate() : !$constraint->evaluate()) {
    return FALSE;
  }
}
return TRUE;
```

- A **non-negated** constraint must `evaluate() === TRUE`.
- A **negated** constraint must `evaluate() === FALSE`.
- The first constraint that fails short-circuits the policy to `FALSE`.
- A policy with **no** constraints evaluates to `TRUE` (matches every request).

## Debug response headers

`onResponse` only acts when `memory_limit_policy.settings:header` is `TRUE`. It then sets:

- `X-Memory-Limit-Memory` = current `ini_get('memory_limit')`.
- `X-Memory-Limit-Override` = `1`/`0` (whether any policy matched).
- `X-Memory-Limit-Policy-Name` = the matching policy id (only when overridden).

Use these to confirm which policy won on a given request.

## CLI note

The web subscriber runs on HTTP requests. For Drush/CLI, the `memory_limit_policy_drush`
submodule applies the limit through a `command-event` hook instead (see that submodule's docs);
its `drush` constraint's own `evaluate()` returns only `isNegated()` for non-CLI clients, so a
`drush` constraint never triggers a web override.
