# The two constraints

Both are standard Symfony/Typed-Data validation constraints in
`src/Plugin/Validation/Constraint/`. They are **not** applied globally — they are added to a field
item list only when the field's third-party setting turns them on (see `configure/validators.md`).

## `CircularReference` (id `CircularReference`)

- Constraint class `CircularReferenceConstraint`; validator `CircularReferenceConstraintValidator`
  (injects `entity_type.manager`).
- Attached via `$field->addConstraint('CircularReference', ['deep' => $deep])`.
- `validate()` skips new/unsaved host entities and empty deltas. For each referenced item it calls
  `isEntityReferenced($host, $target, $field_name, $deep)`:
  - Direct check: if the target's id and entity type equal the host's, it is a self-reference → violation.
  - `deep = TRUE`: it then recurses through the **same field name** on the target, walking the whole
    reference tree, so an indirect loop (A → B → A) is also rejected.
- Violation message: `This entity (%type: %id) cannot be referenced.` placed at path `<delta>.target_id`.
- Because the direct check compares ids, it only makes sense when target type == host type — which
  is exactly when the UI exposes the checkbox.

## `DuplicateReference` (id `DuplicateReference`)

- Constraint class `DuplicateReferenceConstraint`; validator `DuplicateReferenceConstraintValidator`
  (no injected services).
- Attached via `$field->addConstraint('DuplicateReference')`.
- `validate()` collects every non-empty `target_id` in the item list, counts occurrences, and adds a
  violation on each delta whose target id appears more than once.
- Violation message: `The value %label has been entered multiple times.` (label via
  `EntityAutocomplete::getEntityLabels()`), at path `<delta>.target_id`.
- Only meaningful on multi-value (cardinality > 1) reference fields.

## When they fire

Constraints run wherever core validates the entity: the entity form (inline field errors) and any
`$entity->validate()` / typed-data validation path. Note that a plain `$entity->save()` does **not**
auto-run validation, so programmatic imports that bypass `validate()` are not blocked — call
`$violations = $entity->validate();` to enforce.
