<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integer to Decimal converts an existing integer/numeric field to a decimal field type while preserving its data, solving the in-place field-type change core forbids.

---

Drupal does not let you change a field's type once it has data — an integer field cannot simply become a decimal, even though the need is common (you shipped an integer field for a value that turns out to need fractions). The supported path is a new field and a migration, which is disruptive for a change this small.

Integer to Decimal performs the conversion in place, preserving the stored values, so the field becomes a decimal without creating a new field or losing data. That is genuinely useful and also genuinely a schema-altering operation, which is the thing to treat carefully.

Because it rewrites field storage, it is a **maintenance operation, not a runtime feature**: run it deliberately, on a backed-up database, ideally in a maintenance window, and verify the result before trusting production to it. A field-storage conversion that goes wrong is a data problem, so the caution is proportionate to the convenience. It is the right tool for the specific case of "I need this integer field to hold decimals now," used once, not left as a standing capability.

---

- Convert an integer field to decimal.
- Change a field type in place.
- Add decimals to an integer field.
- Avoid a field migration.
- Preserve data during conversion.
- Fix a field that needs fractions.
- Alter field storage safely.
- Run a one-off conversion.
- Back up before converting.
- Convert in a maintenance window.
- Keep existing values.
- Change numeric to decimal.
- Avoid creating a new field.
- Verify the converted data.
- Treat it as maintenance.
- Migrate an integer field's type.
- Handle a schema change.
- Convert then disable.
- Fix a data-model mistake.
- Preserve field configuration.