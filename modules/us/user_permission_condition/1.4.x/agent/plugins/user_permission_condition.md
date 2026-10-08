<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `user_permission` Condition plugin

`Drupal\user_permission_condition\Plugin\Condition\PermissionCondition` — the module's only
plugin. It is a standard core Condition plugin (`@Condition`, extends `ConditionPluginBase`,
implements `ContainerFactoryPluginInterface`), so it plugs into every condition consumer without
any glue of its own.

## Definition

- **id:** `user_permission`, **label:** "User Permission".
- **context_definitions:** one required `user` → `@ContextDefinition("entity:user")`. The plugin
  reads the user to test from context, not from the current session directly. Block visibility and
  Context map the current user into this automatically; a custom consumer must set it (see below).
- **Injected services** (`create()`): `user.permissions` (`PermissionHandlerInterface`) and
  `extension.list.module` (`ModuleExtensionList`). Both are used only to build the human-readable
  permission list — they play no part in evaluation.

## Configuration

- `defaultConfiguration()` → `['permission' => '']` plus the base condition keys (`negate`, etc.).
- `buildConfigurationForm()` adds a single `#type => select` element keyed `permission`, with
  `#empty_value => ''`. Options come from `permissionOptions()`: every permission from the
  permission handler, **grouped as optgroups by the human name of its provider module**
  (`ModuleExtensionList::getName($provider)`), with option labels run through `strip_tags()`.
- `submitConfigurationForm()` stores `$form_state->getValue('permission')` into
  `$this->configuration['permission']`.

## `evaluate()` semantics (important)

```php
public function evaluate() {
  if (empty($this->configuration['permission'])) {
    return $this->isNegated() ? FALSE : TRUE;   // no permission chosen → pass-through
  }
  $user = $this->getContextValue('user');
  if ($user instanceof UserInterface) {
    return $user->hasPermission($this->configuration['permission']);
  }
}
```

- **Empty permission is a deliberate no-op:** with no permission selected the condition passes
  (`TRUE`; `FALSE` when negated) — it never blocks. So an unconfigured instance does nothing.
- With a permission set it returns `$user->hasPermission(...)` on the **contextual user**.
- **Negation** is not applied inside `evaluate()` for the permission branch — the condition
  execution manager (`ConditionAccessResolverTrait` / `Condition::execute()`) applies `negate`
  around the returned boolean. Only the empty-permission short-circuit inverts itself explicitly.
- **Edge case:** if the `user` context is absent/not a `UserInterface`, the method falls through
  and returns `NULL` (falsy). In normal consumers the required context guarantees a user, so this
  is only reachable when a caller wires the plugin up without providing the context.
- **`user 1` (superuser)** returns `TRUE` for any permission via core's `hasPermission()`, as
  everywhere in Drupal.

## `summary()`

Returns translated text: `The user has the permission "@permission"` or, when negated,
`The user does not have the permission "@permission"`. `@permission` is resolved by
`permissionTitle()` → `permissionTitles()`, which formats each as `@permission_title (@module_name)`
via `t()`; an unknown/removed permission id yields `- Invalid permission -`. All interpolation uses
`t()` placeholders, so values are auto-escaped.

## Consuming it in code

```php
$manager = \Drupal::service('plugin.manager.condition');
/** @var \Drupal\Core\Condition\ConditionInterface $condition */
$condition = $manager->createInstance('user_permission', [
  'permission' => 'access administration pages',
  // 'negate' => TRUE,   // optional
]);
$condition->setContextValue('user', $account);   // required context
$passes = $condition->execute();                  // bool, negation applied here
```

Remember the cache implications: a render array whose visibility depends on this must carry the
`user.permissions` cache context (`#cache['contexts'][] = 'user.permissions'`). Core block
visibility handles this for you.

## Implementing your own axis instead

There is no plugin *type* to extend here — this module simply provides one plugin against core's
`Condition` plugin type. To add a different condition (e.g. "user is member of group X"), write your
own class in `src/Plugin/Condition/` with an `@Condition` annotation, the same way this one is
built; you do not subclass `PermissionCondition`.
