<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allowed Values Functions (allowed_values_functions) — agent index

Bind a PHP static method to a list/options field as its **allowed-values callback** by adding a
repeatable `#[AllowedValuesFunction('<entity_type>', '<field_name>')]` attribute — no field-storage
YAML edit and no `hook_entity_field_storage_info_alter()` boilerplate. Version **1.0.1**. Core
`^11`. License GPL-2.0-or-later. **No dependencies, no permissions, no config, no Drush.**

- **The attribute, discovery mechanism, and callback signature (how to use it)** →
  [api/attribute.md](api/attribute.md)
- **The admin report page and its route** → [reports/fields-report.md](reports/fields-report.md)

## What it actually is (from source)

- **Attribute** `Attribute\AllowedValuesFunction` — `#[\Attribute(TARGET_METHOD | IS_REPEATABLE)]`
  with two positional args: `$entityTypeId`, `$fieldName`. Placed on a **public static** method.
- **Discovery** happens at container-compile time, two ways:
  - `AllowedValuesFunctionsServiceProvider::register()` calls
    `registerAttributeForAutoconfiguration()` so attributed methods **on defined services** get the
    tag `allowed_values_functions.allowed_values_function` (via `::addTag()`).
  - `AllowedValuesFunctionsCompilerPass::process()` also token-scans every `*.php` under all
    `container.namespaces` for the literal `#[AllowedValuesFunction`, then reflects **non-service**
    classes' public-static methods. Both sources merge into the collection service's `$functions`.
- **Collection** service `allowed_values_functions.collection`
  (`AllowedValuesFunctionsCollection`, aliased to `...CollectionInterface`) — `listFunctions()`
  maps each entry to an `AllowedValuesFunctionsDefinition` exposing `getEntityTypeId()`,
  `getFieldName()`, `getCallable()` (returns `"Class::method"`).
- **Wiring** `Hook\EntityHooks::entityFieldStorageInfoAlter()` implements
  `hook_entity_field_storage_info_alter()` (`#[Hook]` attribute): for each definition whose
  entity type + field name match, it calls
  `$fields[$fieldName]->setSetting('allowed_values_function', $function->getCallable())`. Core's
  options/list field then invokes that callable normally.
- **Report** `Controller\AllowedValuesFunctionsController::reportFields()` at
  `/admin/reports/fields/allowed-values-functions` (route `allowed_values_functions.reports_fields`;
  menu + local task under `entity.field_storage_config.collection`) — read-only table of
  `entity_type.field_name` → callables.

## Callback signature

```php
#[AllowedValuesFunction('node', 'field_alignment')]
#[AllowedValuesFunction('paragraph', 'field_alignment')]
public static function alignment(
  FieldStorageDefinitionInterface $definition,
  ?FieldableEntityInterface $entity = NULL,
): array {
  return ['left' => t('Left'), 'center' => t('Center'), 'right' => t('Right')];
}
```

The method is the standard core allowed-values callback — same signature, same return shape.
It is **written in module code**, discovered from the attribute; there is no UI or config where a
callable string is entered. Run `drush cr` after adding/removing an attribute (discovery is
compile-time). Provides no `.install`, `.libraries.yml`, or theme.
