# Mechanism

## What it removes

Drupal core's translatable content entity types carry an `EntityUntranslatableFields`
entity-level validation constraint
(`Drupal\Core\Entity\Plugin\Validation\Constraint\EntityUntranslatableFieldsConstraint`).
It produces the familiar error when an **untranslatable** field's value is changed while
editing a translation other than the original/default one:

> "Non-translatable field elements can only be changed when updating the original language."

This module deletes that constraint from **all** entity type definitions, disabling the check
site-wide.

## How (the only code paths)

`remove_entity_untranslatable_field_validation.module`:

```php
function remove_entity_untranslatable_field_validation_entity_type_alter(array &$entity_types) {
  \Drupal::service('remove_entity_untranslatable_field_validation.entity_modifier')
    ->removeUntranslatableEntityFieldValidation($entity_types);
}
```

`src/Entity/EntityModifier.php` (service id
`remove_entity_untranslatable_field_validation.entity_modifier`):

```php
public function removeUntranslatableEntityFieldValidation(array &$entityTypes) {
  foreach ($entityTypes as $entityType) {
    $constraints = $entityType->getConstraints();
    unset($constraints['EntityUntranslatableFields']);
    $entityType->setConstraints($constraints);
  }
}
```

That is the entire module: one hook, one service, one class, no configuration.

## Effect and how to verify

- The constraint is stripped for **every** entity type (nodes, media, custom content entities, …),
  not a selectable subset.
- After a cache rebuild, `\Drupal::entityTypeManager()->getDefinition('node')->getConstraints()`
  no longer contains an `EntityUntranslatableFields` key. If it still does, the module is not
  enabled (or the entity-type cache has not been rebuilt).
- `$entity->validate()` will no longer return an `EntityUntranslatableFields` violation when an
  untranslatable field differs between the default and a non-default translation.

## Trade-off

This is a safety check, not cosmetic. With it removed, an untranslatable ("shared") field can be
written from any translation and becomes effectively last-write-wins across languages. Enable it
only when your editorial/import workflow genuinely needs to edit shared fields per translation.
Disabling the module restores core's normal enforcement.
