<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: `cookie`

Single class `Drupal\cookie_condition\Plugin\Condition\Cookie`
(`src/Plugin/Condition/Cookie.php`), the module's only code.

## Install / enable

`drush en cookie_condition -y`. No dependencies beyond core, no install step, no config to import.
Once enabled the `cookie` condition appears wherever Drupal collects condition plugins.

## Plugin definition

Annotation `@Condition`:
- `id = "cookie"`
- `label = @Translation("Cookie")`
- `description = @Translation("Allows to select a particular cookie with a specific value.")`

Extends `Core\Condition\ConditionPluginBase` and implements
`ContainerFactoryPluginInterface`. `create()` injects the core `request_stack` service into
`$this->requestStack`.

## Configuration (no separate config object)

The condition stores its settings inside the *host* configuration (e.g. the block's
`visibility.cookie` mapping in the block config entity) — the module ships no `config/install`
or `config/schema` of its own.

`defaultConfiguration()` returns:

| key           | default | meaning                                             |
|---------------|---------|-----------------------------------------------------|
| `cookie_name` | `''`    | name of the cookie to inspect                       |
| `operator`    | `'is'`  | `is` = exact match, `contains` = substring match    |
| `cookie_value`| `''`    | value to compare against                            |
| `negate`      | `false` | inherited from `ConditionPluginBase` (invert result)|

`buildConfigurationForm()` renders a `cookie_name` textfield, an `operator` select
(`is` → "=", `contains` → "contains"), and a `cookie_value` textfield, then appends the base
form (which adds the "Negate the condition" checkbox). `submitConfigurationForm()` saves the
three custom values before calling the parent.

## Evaluation logic — `evaluate()`

```
$cookie_name  = configuration['cookie_name']
$operator     = configuration['operator']
$cookie_value = configuration['cookie_value']

// Empty name + not negated => condition passes (no constraint).
if (!$cookie_name && !$this->isNegated()) return TRUE;

$cookies = request_stack->getCurrentRequest()->cookies;   // Symfony cookie bag
if ($operator === 'is')  return $cookies->get($cookie_name) === $cookie_value;   // strict
return strpos($cookies->get($cookie_name, ''), $cookie_value) !== false;         // substring
```

Notes:
- `is` uses strict `===`, so a missing cookie (`null`) never equals a non-empty configured value.
- `contains` supplies a `''` default to `get()`, so a missing cookie is treated as empty string.
- The plugin never sets, writes, or echoes the cookie — it only reads the current request bag.
- `negate` is applied by the condition-execution layer (`ConditionAccessResolverTrait` /
  `ExecutableManager`), which flips the boolean when the checkbox is set; `evaluate()` itself
  only short-circuits the empty-name case on `isNegated()`.

## Cache — `getCacheContexts()`

Returns the parent contexts plus `'cookies:' . $cookie_name` when `cookie_name` is set. This is
the correct cache context for cookie-varying output: a block placed with this condition is cached
per distinct value of that cookie, so different visitors get correctly varied (not shared) markup
behind the render/page cache.

## Summary — `summary()`

Human-readable label for the admin UI, built with `t()` and placeholders `@name` / `@operator` /
`@value`:
- negated → `Cookie "@name" is NOT equal to "@value"`
- otherwise → `Cookie "@name" has "@value" value`

## How to operate it

- **Block visibility:** on *Place block* / block config, open the "Cookie" visibility tab, set
  cookie name, operator, value, and optionally "Negate". The block then renders only when the
  condition passes (or fails, if negated).
- **Other consumers:** any code using the `plugin.manager.condition` service can instantiate
  `cookie`, apply configuration, and call `execute()`/`evaluate()` — e.g. custom access checks,
  Layout Builder section visibility, or contrib that gathers conditions.
- **Reminder:** client-supplied cookies are forgeable; use this for presentation/visibility, not
  for protecting restricted content (gate that on permissions or entity access).
