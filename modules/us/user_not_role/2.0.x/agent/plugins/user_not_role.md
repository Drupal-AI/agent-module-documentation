<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: `user_not_role`

`src/Plugin/Condition/UserNotRole.php` — `final class UserNotRole extends ConditionPluginBase implements ContainerFactoryPluginInterface`.

## Definition

```php
#[Condition(
  id: 'user_not_role',
  label: new TranslatableMarkup('User Not Role'),
  context_definitions: [
    'user' => new EntityContextDefinition(
      data_type: 'entity:user',
      label: new TranslatableMarkup('User'),
    ),
  ],
)]
```

- **id:** `user_not_role`
- **context:** `user` → `entity:user` (block visibility supplies this via `@user.current_user_context:current_user`).
- **Injected services:** `entity_type.manager` (to load `user_role` config entities for the checkbox labels) and `logger.factory` (channel `user_not_role`).

## Configuration

- `roles`: array of role IDs the user must NOT have (schema `condition.plugin.user_not_role` → `roles: sequence<string>`).
- `negate`: inherited boolean from `ConditionPluginBase`.
- `defaultConfiguration()`: `['roles' => []]`.
- `submitConfigurationForm()`: stores `array_filter($form_state->getValue('roles'))` (drops unchecked boxes).

## `evaluate()`

```php
if (empty($this->configuration['roles']) && !$this->isNegated()) {
  return TRUE;
}
$user = $this->getContextValue('user');
return empty(array_intersect($this->configuration['roles'], $user->getRoles()));
```

- Returns TRUE when the user shares **no** role with the configured set; FALSE otherwise.
- On `ContextException` (no valid user context) it logs a warning and returns **FALSE** (fails closed / block hidden).
- **Negation is applied by core**, not here: `ConditionManager::execute()` calls `evaluate()` and returns `isNegated() ? !$result : $result`. Consumers (block access, Layout Builder) go through `execute()`, so a negated plugin shows the block to users who DO have one of the roles.

## `summary()`

- No roles → *"No restriction"*.
- Not negated → *"The user is not any of @roles"*.
- Negated → *"The user can be one of @roles"*.
- Role labels are pulled from loaded `user_role` entities and are HTML-escaped for the form `#options`.

## `getCacheContexts()`

Remaps the applied `user` cache context to **`user.roles`**:

```php
$contexts[] = $context === 'user' ? 'user.roles' : $context;
```

This is the correct, minimal variance for a role-based condition and prevents a per-role visibility result from being cached across users with different role sets.

## Reuse

Because it is a standard condition plugin, it is available to any condition consumer — block visibility, Layout Builder section visibility, Page Manager variant selection, or custom code that instantiates conditions via `plugin.manager.condition`. Provide the `user` context and call `execute()` to get the negation-aware boolean.
