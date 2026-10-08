<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Saudi ID Validator checks Saudi National ID / Iqama numbers via a service, Form API validator and entity constraint.

---

Saudi ID Validator validates Saudi National ID and Iqama (residency permit) numbers entirely offline — checking format (ten ASCII digits), number type (leading `1` = National ID, `2` = Iqama), and the official Luhn checksum — through one reusable service exposed as a Form API `#element_validate` validator and an entity field `SaudiId` constraint. It lets forms and entities reject invalid IDs without contacting any external service.

Inject `SaudiIdValidatorInterface` (alias `saudi_id_validator.validator`) for `isValid()`, `detectType()`, `isSaudiCitizen()`, `isResident()` and `getMetadata()`; attach `SaudiIdElementValidator::validate` to a form element; or add `->addConstraint('SaudiId')` (optionally with `requireType`) to a field so every write path — entity forms, JSON:API, REST, migrations, programmatic saves — is covered at once. Automatic by-machine-name validation can be switched on and configured at Administration → Configuration → System → Saudi ID Validator, gated by `administer saudi id validator`. Validation is local, so ID data stays on the server. Version 1.1.0 adds Drupal 12 compatibility (now `^10.3 || ^11 || ^12`); no behaviour changed. Supports Drupal 10.3+, 11 and 12; PHP 8.3+.

---

- Validate Saudi National ID numbers.
- Validate Iqama (resident) numbers.
- Check a number's format — exactly ten ASCII digits.
- Detect the type from the leading digit (citizen vs. resident).
- Verify the official Luhn checksum.
- Reject Arabic-Indic digits, zero-width and non-breaking spaces.
- Validate entirely offline, with no external calls.
- Inject one reusable validation service across your code.
- Attach a Form API `#element_validate` callback to a form field.
- Add the `SaudiId` entity/typed-data constraint to a field.
- Cover JSON:API, REST, migration and programmatic writes at once.
- Restrict a field to one ID type with `requireType`.
- Read an immutable `IdMetadata` verdict, including why a number failed.
- Surface a precise failure reason (length, leading digit, or checksum).
- Enable automatic validation of fields by machine name, no code needed.
- Configure the watched field-name list in the admin UI.
- Optionally show the detected ID type back to the user.
- React to validation via `SaudiIdValidated`/`SaudiIdValidationFailed` events.
- Generate correct-by-construction test IDs with `SaudiIdGenerator`.
- Keep entered ID data on the server (no registry lookup).
- Gate configuration behind `administer saudi id validator`.
- Run on Drupal 10.3+, 11 and 12 with PHP 8.3+.
