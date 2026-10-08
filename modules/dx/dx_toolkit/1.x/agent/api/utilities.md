<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Utility classes, plugin managers, State & ServiceInstance

All classes are in namespace `Drupal\dx_toolkit` (files under `src/`). These are static helpers
and base classes you call from your own code — none are exposed over HTTP.

## Color (`src/Color.php`, extends core `Component\Utility\Color`)

- `normalize($hex)` (protected) — expands short hex, validates, **throws `InvalidArgumentException`
  on invalid input**; `hexToRgba($hex, $opacity=1)` → `"rgba(r, g, b, a)"`.
- `luminance($hex)` — gamma-corrected relative luminance; `luminanceDifference($h1, $h2)` — WCAG-style
  contrast ratio.
- Text-color pickers returning black `#000000` / white `#ffffff`: `contrast50()` (midpoint of int
  value), `contrastYIQ()` (YIQ ≥128), `contrastLuminance()` (larger luminance diff).
- `calculateBestContrast($hex, array $candidates)` — candidate with the greatest luminance
  difference, or NULL if `$candidates` empty.

## Json (`src/Json.php`, extends core `Serialization\Json`)

- `decode($string, $clean_string = TRUE)` — cleans then defers to core decode.
- `cleanJsonString($json)` — strips control chars (0–31, 127) and a leading UTF-8 BOM (`efbbbf`).
  Useful for parsing JSON from files/editors that inject invisible bytes.

## Environment (`src/Environment.php`)

- `isCli()` — TRUE under `cli`/`cli-server`/`phpdbg` or when `STDIN` is defined.

## ArrayUtilities (`src/ArrayUtilities.php`, abstract, static)

- `arrayKeysCombined($a, $b=null)` — keys of `$a` → keys of `$b` (or `$a` keys as both).
- `arrayMapMerged(callable, $array, ...$arrays)` — one-level flatten of an array_map result.
- `arrayKeyColumn($array, $column)` — like `array_column` but keeps original parent keys.
- `arraySortByKeys($target, $key_source, $by_reference=false)` — reorder `$target` by `$key_source`'s keys.

## OptionsGenerator (`src/OptionsGenerator.php`, abstract)

- `entitiesAsOptions(EntityStorageInterface)` — loadMultiple → `id => label`.
- `optionsFromEntities(array $entities)` — filter to entities → `id => label`.

## EntityFieldPropertyAdapter (`src/EntityFieldPropertyAdapter.php`)

Constructed with an entity and a default property (`'value'`). `fieldPropertyValues($field, $prop)`
returns a property column across all field deltas (array `$prop` → per-delta intersected subset);
`fieldPropertyValue()` returns the first.

## ServiceInstance pattern

`ServiceInstanceInterface` + `ServiceInstanceTrait` (`getServiceName()` abstract; `getService()`
returns `\Drupal::service(getServiceName())` typed as `static`). Implement it so callers write
`MyService::getService()->method()` in static contexts. `PluginManager` and `EntityGeneratorManager`
use the trait (`EntityGeneratorManager::getServiceName()` = `plugin.manager.entity_generator`).

## Extended plugin base/manager (`src/Plugin/`)

- `PluginManager` (abstract, extends `DefaultPluginManager`): `createInstances(?array $ids)` (all
  or given ids), `getPluginDerivatives($base_id)` (definitions whose `id` == base), `createDerivativeInstances($base_id)`,
  `optionLabels()` (id → label map for FAPI `#options`, label key overridable via `labelKey()`).
- `PluginBase` (abstract): `label()` and `pluginDescription()` cast annotation TranslatableMarkup to string.
- `PluginManagerPropertyQueryTrait::findByProperties(array $values)` — definitions matching all given
  property values (plugin analogue of entity `loadByProperties`).

## State wrapper (`src/StateBase.php`, `src/State/PreInstallState.php`)

`StateBase` (abstract, implements `StateInterface`) wraps core State. Subclass and implement
`name()`; optionally override `context()` (string/array/callable/object-with-toString → composed
key prefix). API: `get($default)`, `set($value)`, `delete()`, `setArrayValue($k,$v)`,
`arrayValue($k)`, `hasArrayValue($k)`, `setState()` (inject a State service; otherwise falls back to
`\Drupal::state()`). Keys are `context:name`; `#`/`$` are stripped from context. Concrete
`PreInstallState` (name `preInstall`, context `module`) is set TRUE in `hook_module_preinstall` and
FALSE in `hook_install` (see `dx_toolkit.module`) so code can detect the pre-install phase.

## Extension helper (`src/Extension.php`, `ExtensionTrait`, `ExtensionBase`)

Static module metadata: `Extension::name()` = `dx_toolkit`, `label()` = `DX Toolkit`,
`extensionPath()`, `root()` (= `DRUPAL_ROOT`), `module()`. `ExtensionTrait` intentionally uses
`\Drupal::moduleHandler()` as a documented service-locator exception for static access.
`AsArrayTrait::asArray($value)` coerces any value to an array (empty → `[]`).
