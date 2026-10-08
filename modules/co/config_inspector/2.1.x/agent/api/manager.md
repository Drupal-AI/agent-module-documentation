<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service API: `config_inspector.manager`

Class `Drupal\config_inspector\ConfigInspectorManager` (`src/ConfigInspectorManager.php`).
Constructed with `config.factory`, `config.typed`, `cache.discovery`, `cache.bootstrap`.
It uses core's `SchemaCheckTrait` and clears typed-config/constraint caches on construction so
every inspection sees an up-to-date schema.

```php
$m = \Drupal::service('config_inspector.manager');
```

## Methods you'd call

| Method | Returns | Purpose |
|---|---|---|
| `hasSchema(string $name)` | `bool` | Does this config name have a schema? |
| `getConfigData(string $name)` | `array|null` | The typed-config value array. |
| `getConfigSchema(string $name)` | `TraversableTypedDataInterface` | The typed config element tree. |
| `checkValues(string $name)` | `array|bool` | `TRUE` = schema-compliant; `FALSE` = no schema; **array of errors** = mismatches. |
| `checkValidatabilityValues(string $name)` | `ConfigSchemaValidatability` | Per-property-path validatability; `->computePercentage()`, `->isComplete()`, `->getValidatabilityPerPropertyPath()`. Throws `LogicException` if no schema. |
| `validateValues(string $name)` | `ConstraintViolationListInterface` | Runs the config object's validation constraints; empty list = valid. |
| `convertConfigElementToList($schema)` | `array` | Flattens a schema element tree to dot-keyed `Element` objects. |
| `ConfigInspectorManager::violationsToArray($violations)` | `array` | Static: flattens a violation list keyed by property path. |

## Typical use

```php
$m = \Drupal::service('config_inspector.manager');
$name = 'system.site';

if ($m->hasSchema($name)) {
  $result = $m->checkValues($name);          // TRUE or array of schema errors
  if ($result === TRUE) {
    $pct  = $m->checkValidatabilityValues($name)->computePercentage(); // 0.0–1.0
    $bad  = $m->validateValues($name);        // ConstraintViolationList
    $count = $bad->count();                    // 0 = data passes all constraints
  }
}
```

Notes:
- "Validatability" deliberately does **not** count a lone `PrimitiveType` (or `PrimitiveType`
  + `NotNull`) constraint as validatable, unless the value's class is a boolean, URI, datetime,
  or duration — an arbitrary string/int/float is considered under-validated.
- The manager is read-only; it never writes config.
