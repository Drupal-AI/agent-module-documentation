<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config `entity_model.settings`, argument injection, AccountProxy override

There is **no settings form** (`configure` is null). The two toggles live in the
`entity_model.settings` config object and are changed via config import or `drush config:set`.

## Config object

- Install defaults — `config/install/entity_model.settings.yml`:
  `override_account_proxy: false`, `resolve_form_state_argument_type: false`.
- Schema — `config/schema/entity_model.schema.yml`: `type: config_object`, both keys `boolean`.

```bash
drush config:set entity_model.settings override_account_proxy true -y
drush config:set entity_model.settings resolve_form_state_argument_type true -y
```

Both features are read at **container-build time** in part (see the service provider), so rebuild
caches (`drush cr`) after changing `override_account_proxy`.

## Service provider — `src/EntityModelServiceProvider.php`

`EntityModelServiceProvider implements ServiceModifierInterface`. In `alter(ContainerBuilder $container)`:

1. Reads `entity_model.settings` via `BootstrapConfigStorageFactory::get()->read()`. If
   `override_account_proxy` is truthy, sets the `current_user` service class to
   `Drupal\entity_model\Session\AccountProxy`.
2. Always **prepends** `entity_model.argument_resolver` (a `Reference`) to the front of argument index
   `1` of `http_kernel.controller.argument_resolver`, so `ModelValueResolver` runs before core's
   resolvers.

## Argument resolver — `src/Controller/ArgumentResolver/ModelValueResolver.php`

`ModelValueResolver implements ValueResolverInterface`. Config factory is lazy-loaded
(`getConfigFactory()` → `\Drupal::configFactory()`) to avoid a circular dependency.

`resolve(Request $request, ArgumentMetadata $argument)`:

- If the argument type is a `FormStateInterface` **and** `resolve_form_state_argument_type` is enabled,
  runs `doResolve()`. This lets you type-hint `$formState` instead of the core-required `form_state`.
- If the argument type is a `ContentEntityInterface`, runs `doResolve()` **only** when the route is a
  canonical-style route (regex matches `entity.*.canonical|preview_link|preview|latest_version`) **or**
  the route option `_enable_fuzzy_argument_resolving` is truthy. Set that option on a custom route to
  opt in.

`doResolve()` matching order: (1) request attribute whose name equals the argument name and whose type
matches; (2) attribute under the snake_cased argument name; (3) the first attribute of a matching type;
(4) the argument's default value; else `NULL`. `isTypeMatch()` requires
`is_object($attribute) && is_a($attribute, $argument->getType())`. It only yields entities **already
upcast into the request by core's route parameter conversion** — it does not load arbitrary entities or
alter route access.

## AccountProxy override — `src/Session/AccountProxy.php`

`AccountProxy extends \Drupal\Core\Session\AccountProxy`. When `override_account_proxy` is on, this
replaces `current_user`. `getAccount()` lazily loads the full `User` entity (`loadUserEntity($this->id)`)
and caches it in `$fullUser`, so callers get a `UserInterface` instead of a lightweight `UserSession`.
`setAccount()` unwraps a passed proxy to the cached account; identity/role/permission/langcode/name/
email/timezone accessors delegate to `getCachedAccount()` (the parent's `getAccount()`). Motivated by
core issue 2345611.
