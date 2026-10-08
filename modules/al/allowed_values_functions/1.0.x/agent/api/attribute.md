<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using #[AllowedValuesFunction] (attribute + discovery)

## Install / enable

`composer require drupal/allowed_values_functions` then `drush en allowed_values_functions`.
No dependencies, no config, nothing to set up. All wiring is by attribute in **your** module code.

## Step 1 — write the callback

Add a **public static** method (in any custom module) with the core allowed-values signature and
tag it with one or more `#[AllowedValuesFunction(entityTypeId, fieldName)]` attributes. The
attribute is `#[\Attribute(\Attribute::TARGET_METHOD | \Attribute::IS_REPEATABLE)]`
(`src/Attribute/AllowedValuesFunction.php`), so repeat it to serve several fields/entity types.

```php
use Drupal\allowed_values_functions\Attribute\AllowedValuesFunction;
use Drupal\Core\Entity\FieldableEntityInterface;
use Drupal\Core\Field\FieldStorageDefinitionInterface;

class FieldHelper {
  #[AllowedValuesFunction('node', 'field_headline_alignment')]
  #[AllowedValuesFunction('paragraph', 'field_subheadline_alignment')]
  public static function alignment(
    FieldStorageDefinitionInterface $definition,
    ?FieldableEntityInterface $entity = NULL,
  ): array {
    return ['left' => t('Left'), 'center' => t('Center'), 'right' => t('Right')];
  }
}
```

- Return an array keyed by the stored value → (translated) label — identical to what core's native
  `allowed_values_function` expects. The optional `$entity` lets options depend on the edited entity.
- Constructor args map positionally: `$entityTypeId`, then `$fieldName`
  (`src/Attribute/AllowedValuesFunction.php`).

## Step 2 — clear caches

Discovery is **compile-time**, so run `drush cr` after adding, changing, or removing an attribute.
Nothing takes effect until the container is rebuilt.

## How discovery works (two paths, both compile-time)

`AllowedValuesFunctionsServiceProvider::register()` (`src/AllowedValuesFunctionsServiceProvider.php`):

1. **Service methods** — `registerAttributeForAutoconfiguration(AllowedValuesFunction::class, [self::class,'addTag'])`.
   For attributed methods on classes that are container services, `addTag()` adds tag
   `allowed_values_functions.allowed_values_function` carrying `class`, `method`, `entity_type`,
   `field_name` (from `$reflector->getDeclaringClass()` and the attribute).
2. **Non-service classes** — it also registers `AllowedValuesFunctionsCompilerPass`
   (`TYPE_BEFORE_OPTIMIZATION`). `process()` (`src/DependencyInjection/Compiler/AllowedValuesFunctionsCompilerPass.php`):
   - reads existing tagged service ids first, then
   - walks every path in the `container.namespaces` parameter with Symfony `Finder`, and for each
     `*.php` file **token-scans the raw source** for the literal `#[AllowedValuesFunction` before
     doing anything else (an explicit optimization comment notes this avoids autoloading classes
     with unresolvable compile-time deps);
   - only for files that contain the marker does it `new \ReflectionClass($fqcn)` (wrapped in
     `try/catch (\Throwable)` — unresolvable classes are skipped) and read
     `IS_PUBLIC | IS_STATIC` methods' `AllowedValuesFunction` attributes;
   - merges all entries keyed by `Class::method` and sets them as the `$functions` argument of the
     `allowed_values_functions.collection` service.

Because both paths key on `Class::method`, a service method that is also on disk is de-duplicated.

## The collection + definition API

- Service `allowed_values_functions.collection` = `AllowedValuesFunctionsCollection`, aliased to
  `AllowedValuesFunctionsCollectionInterface` (`allowed_values_functions.services.yml`, with
  `autoconfigure`/`autowire` on). Constructor arg `$functions` is `[]` in YAML and replaced by the
  compiler pass.
- `listFunctions(): AllowedValuesFunctionsDefinitionInterface[]` maps each raw entry to an
  `AllowedValuesFunctionsDefinition` with `getEntityTypeId()`, `getFieldName()`, and
  `getCallable()` (returns `"$class::$method"`).

## How the field gets wired

`Hook\EntityHooks::entityFieldStorageInfoAlter()` implements
`hook_entity_field_storage_info_alter()` (declared with core's `#[Hook]` attribute; the collection
is `#[Autowire]`d in). For every definition it iterates `listFunctions()` and, when
`$entity_type->id()` matches and `$fields[$fieldName]` exists, calls
`$fields[$fieldName]->setSetting('allowed_values_function', $function->getCallable())`. From then on
core's list/options field resolves allowed values through your method exactly as if you had set the
setting by hand. The module never invokes the callable itself — core does, at field render/validation.

## Notes

- Target the field's **base name** (e.g. `field_headline_alignment`), and an existing
  **entity type id** (e.g. `node`, `paragraph`). A mismatch is silently ignored (the `continue` in
  the hook).
- Works for any field whose storage honors `allowed_values_function` (core list_string /
  list_integer / list_float and options-based fields).
- No settings form, no permission, no schema — the module contributes only discovery + wiring.
