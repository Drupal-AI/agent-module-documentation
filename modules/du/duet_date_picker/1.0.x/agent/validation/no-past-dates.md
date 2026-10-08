<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NoPastDates validation constraint

`src/Plugin/Validation/Constraint/NoPastDatesConstraint.php` +
`NoPastDatesConstraintValidator.php`. Rejects a submitted date that falls before the current
moment. It is not attached statically — the widgets add it at runtime when their **"Disallow past
dates"** (`no_past_dates`) setting is on.

## Constraint

- `@Constraint(id = "NoPastDates", type = "datetime")`, extends Symfony `Constraint`.
- Message property `$dateIsPast`: *"The selected date is in the past. Please select a date later
  than now."*

## Validator (`NoPastDatesConstraintValidator`)

- `validate($items, Constraint $constraint)` iterates the field item list; for each item checks
  `value` and (for daterange) `end_value`. A past value adds a violation with `$constraint->dateIsPast`
  at the corresponding property path.
- `isPastDate($value, $date_value_type)`:
  - builds `now`/`today` and the value `\DateTime` both in
    `DateTimeItemInterface::STORAGE_TIMEZONE` (UTC), so the comparison uses the field's storage TZ;
  - threshold is **`now`** for `datetime` fields, **`today`** for date-only fields
    (`getSetting('datetime_type')`);
  - returns `true` when `value` timestamp < threshold timestamp.

## How it is applied

In each widget's `formElement()`, when `$settings['no_past_dates']` is true:
`$this->fieldDefinition->addConstraint('NoPastDates')`. The widget also passes today's date to the
picker as the `min` attribute (via `hook_preprocess_duet_date_picker`), giving a client-side hint;
the constraint is the server-side enforcement (covers both start and end of a range).

Parsing is pure `\DateTime`/`DrupalDateTime` — no eval, no query building.
