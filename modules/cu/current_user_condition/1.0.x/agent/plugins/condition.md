<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: current_user_condition

Source: `src/Plugin/Condition/CurrentUserCondition.php`
Class: `Drupal\current_user_condition\Plugin\Condition\CurrentUserCondition`
Extends `ConditionPluginBase`, implements `ContainerFactoryPluginInterface`.

## Install / enable
`composer require drupal/current_user_condition` then enable `current_user_condition`
(depends on core `user`). No settings route — the plugin is configured wherever conditions are
exposed (e.g. block visibility tabs).

## Plugin definition
Annotation `@Condition(id = "current_user_condition", label = @Translation("Current users profile"))`.
Injected via `create()`: `current_user` (AccountInterface) and `current_route_match`
(RouteMatchInterface).

## Configuration
- `defaultConfiguration()` → `['status' => FALSE]` (plus base condition keys `id`, `negate`).
- `buildConfigurationForm()` adds one checkbox `status`, title "Is the current authenticated users
  profile page", defaulting to the stored value.
- `submitConfigurationForm()` stores `$form_state->getValue('status')` into `configuration['status']`.
- Config schema `condition.plugin.current_user_condition` (`schema/current_user_condition.schema.yml`)
  maps `status` as boolean (inherits `condition.plugin`, which carries `id`/`negate`).

## Evaluate logic (`evaluate()`)
```
if (!status) return TRUE;                       // unchecked → no restriction, always true
$account = routeMatch->getParameter('user');
return routeMatch->getRouteName() === 'entity.user.canonical'
       && $account->id() === currentUser->id();
```
So when checked, it is true only on the current user's own canonical profile page (`/user/{uid}`).
The route-name check is evaluated first and short-circuits `&&`, so `$account` is only dereferenced
on the canonical user route where the `user` parameter is present.

## Negation & summary
`summary()` returns "The current page is the current authenticated users profile page", or the
negated form when `isNegated()`. Negation is handled by the base class via the `negate` config key.

## Caching
`getCacheContexts()` adds the `user` cache context to the base contexts only when `status` is TRUE
(so block cache varies per user when the condition is active); returns base contexts otherwise.

## Using it in code
Instantiate through the `plugin.manager.condition` service, set `['status' => TRUE]` (and optionally
`['negate' => TRUE]`), then call `execute()`/`evaluate()`. Any condition-aware system (block
visibility, Layout Builder, custom access logic) can consume it by plugin id `current_user_condition`.
