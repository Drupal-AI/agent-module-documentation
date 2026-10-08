<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom validation constraints

Five Symfony/Drupal validation constraints in `src/Plugin/Validation/Constraint/`, each with a paired
`*Validator`. They are ordinary constraints — add them to request-class properties (attributes or
annotations) or use them anywhere the `api_toolkit.validator` (or core validator) runs. Every validator
short-circuits (passes) on `NULL`/empty-string value, and throws `UnexpectedTypeException` for
non-scalar, non-Stringable values. The validators are resolved via Drupal's class resolver
(`ContainerInjectionInterface`).

## `EntityExists` (id `entity_exists`)
Passes when an entity with the given field value exists.
- Options: `entityTypeId` (**required**), `fieldName` (default `uuid`), `bundle` (optional),
  `message` (`No @entityType with %fieldLabel %value exists.`).
- Validator loads via `storage->loadByProperties([fieldName => value])`; violation
  (`INVALID_ID_ERROR`) if none found or the bundle mismatches.

```php
#[Assert\All([ new EntityExists(entityTypeId: 'node', bundle: 'example_page', fieldName: 'nid') ])]
public array $similarPages = [];
```

## `EntityUnique` (id `entity_unique`)
Passes when **no** entity already has the given field value (uniqueness check).
- Options: `entityTypeId` (**required**), `fieldName` (**required**), `bundle` (optional),
  `message` (`An entity with %fieldLabel %value already exists.`).
- Violation code `NOT_UNIQUE_ERROR` when a match is found (bundle added to the property filter when set).

## `Enum` (id `enum`, default option `enum`)
Passes when the value is a valid case of a **backed enum**.
- Options: `enum` (**required** — the enum class-string; default option so `new Enum(MyEnum::class)`
  works), `message` (lists `%cases`).
- Validator asserts the class is a `BackedEnum` and checks `::tryFrom($value)`; violation code
  `NO_SUCH_CASE_ERROR` (Symfony `Choice::NO_SUCH_CHOICE_ERROR`). Note the `ApiRequestNormalizer` already
  applies this automatically when a request property is type-hinted as a backed enum.

## `Langcode` (id `langcode`)
Passes when the value is the langcode of an installed language.
- Option: `message` (`%value is not a valid language code.`).
- Validator checks `language_manager->getLanguage($value)`; violation code `INVALID_LANGCODE_ERROR`.

## `MigrationSourceExists` (id `migration_source_exists`, default option `migration`)
Passes when the value is a source ID present in a migration's id-map.
- Options: `migration` (**required** — migration plugin id), `invalidIdMessage`,
  `destinationIdsLookupFailedMessage`.
- Validator creates the migration and calls `idMap->lookupDestinationIds([$value])`; violations
  `INVALID_ID_ERROR` (no mapping) or `DESTINATION_IDS_LOOKUP_FAILED_ERROR` (on `MigrateException`).
  Requires core `migrate`.

Validation messages ship translated under `translations/` (`api_toolkit.*.po` for these constraints,
`symfony_validation.*.po` for built-in Symfony constraints); import via
`/admin/config/regional/translate/import`.
