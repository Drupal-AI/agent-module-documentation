# Validation: the `Phone` constraint

The field type declares `constraints = { "Phone" = {} }`. The constraint plugin lives at
`Drupal\phonenumber\Plugin\Validation\Constraint\PhoneConstraint` (id `Phone`) and is validated by
`PhoneConstraintValidator` (injects `entity_type.manager` and core `country_manager`). This is the
base-module, server-side check that runs on entity save / typed-data validation. Deeper
libphonenumber format/type validation is layered on by the `phonenumber_validation` submodule.

## What it checks (`PhoneConstraintValidator::validate()`)

Order of checks for a non-empty item:

1. **Skip** when the field is optional and `local_number` is blank, or both `phone_number` and
   `local_number` are empty.
2. **Required** — if the field is required and `local_number` is blank → violation
   `required` (`@field_name field is required.`).
3. **Allowed country** — builds the allowed set from field settings `allowed`
   (`all`/`include`/`exclude`) + `countries`, case-matching to the `country_manager` list keys.
   Violation `allowedCountry` when a `phone_number` has no resolved `country_iso2`, or the
   `country_iso2` is not in the allowed set.
4. **Uniqueness** — only when storage setting `unique` is on and `PhoneItem::isUnique()` returns
   false → violation `unique` (`A @entity_type with @field_name @value already exists.`).
5. A caught `PhoneException` produces violation `validity`.

## Constraint messages

| Property | Default message |
|---|---|
| `required` | `@field_name field is required.` |
| `unique` | `A @entity_type with @field_name @value already exists.` |
| `validity` | `The @field_name @value is invalid for the following reason: @message.` |
| `allowedCountry` | `The country of @value provided for @field_name is not allowed in the list of countries.` |

## Also enforced elsewhere

- `PhoneItem::propertyDefinitions()` adds a `Length` constraint (max 16) on `phone_number` and
  length caps on the other columns; `getConstraints()` adds a `ComplexData`/`Length` max-16 check.
- The `phone` form element's `validatePhone()` (see [widget.md](widget.md)) cleans the submitted
  `phone_number` to digits and rejects non-digit input before the constraint runs.
- `strict_mode` / `validation_number_type` field settings drive client-side input restriction in
  the JS widget; they are not re-enforced by this base constraint (the `phonenumber_validation`
  submodule adds the libphonenumber-backed type/format constraint).
