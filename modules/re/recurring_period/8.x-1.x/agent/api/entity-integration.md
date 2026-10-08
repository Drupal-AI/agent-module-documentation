<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storing a period on an entity

Two helpers let a calculated `Period` be persisted as an entity: `Period::toEntity()` on the value
object, and `PeriodEntityTrait` for the entity class.

## Period::toEntity()

```php
$entity = $period->toEntity('my_period_entity', ['uid' => 1]);
$entity->save();
```

`toEntity($entity_type_id, array $values = [])` returns an **unsaved** entity created from the period's
dates. It reads the target entity type's entity keys and populates them:

- If the entity type declares a `date_range` key → sets a single `daterange` field value
  (`value` + `end_value`, in `DATETIME_STORAGE_FORMAT`).
- Otherwise → sets the `start_date` and `end_date` keyed fields (storage-format strings).
- If a `label` key exists, it is set from the period's label (unless `$values` already supplies it).

`$values` is merged in and wins over the period-derived values for any key it provides.

## PeriodEntityTrait / PeriodEntityInterface

`Drupal\recurring_period\Entity\PeriodEntityTrait` gives an entity class period accessors and a base
field factory. The entity class should implement `Drupal\recurring_period\Entity\PeriodEntityInterface`.

Accessor methods added by the trait:

| Method | Returns | Notes |
| --- | --- | --- |
| `getStartDate()` | `DrupalDateTime` | Reads the `date_range` field's `start_date`, or the `start_date`-keyed field's `date`. |
| `getEndDate()` | `DrupalDateTime` | Symmetric to above. |
| `getDuration()` | `int` | Seconds between end and start. |
| `contains(DrupalDateTime $date)` | `bool` | Half-open `[start, end)`, compared as timestamps. |

> Note: the entity trait's accessors return **`DrupalDateTime`**, whereas the `Period` value object
> returns `\DateTimeImmutable`.

### Base field definitions

Call the static factory from your entity type's `baseFieldDefinitions()` and merge the result:

```php
public static function baseFieldDefinitions(EntityTypeInterface $entity_type) {
  $fields = parent::baseFieldDefinitions($entity_type);
  $fields += self::periodBaseFieldDefinitions($entity_type);
  return $fields;
}
```

`periodBaseFieldDefinitions(EntityTypeInterface $entity_type)`:

- Throws `UnsupportedEntityTypeDefinitionException` if the entity class does not implement
  `PeriodEntityInterface`.
- If the entity type has a `date_range` key → returns one revisionable `daterange` field ("Period
  date") with `daterange_default` view/form display (requires the core **datetime_range** module).
- Else if it has both `start_date` and `end_date` keys → returns two revisionable `date` fields
  ("Period start date" / "Period end date") (requires the core **datetime** module).
- Else → throws `UnsupportedEntityTypeDefinitionException`.

So the consuming entity type must define entity keys — either `date_range`, or the pair
`start_date`+`end_date` — pointing at the field names to create.
