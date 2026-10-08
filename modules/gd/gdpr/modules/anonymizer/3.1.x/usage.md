<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anonymizer is a GDPR submodule that provides a pluggable system for turning a value into anonymized/fake data, used by the other GDPR submodules (gdpr_fields, gdpr_dump, gdpr_tasks) to scrub personal data.

---

The module defines an **Anonymizer plugin type** (`Plugin/Anonymizer`, annotation `@Anonymizer`, interface `AnonymizerInterface`, base class `AnonymizerBase`, plugin manager service `plugin.manager.anonymizer`). Each plugin implements `anonymize($input, ?FieldItemListInterface $field = NULL)` and returns a replacement value. Ten anonymizers ship: `email_anonymizer`, `username_anonymizer`, `text_anonymizer`, `long_text_anonymizer`, `random_text_anonymizer`, `number_anonymizer`, `date_anonymizer`, `password_anonymizer`, `uri_anonymizer` and `clear_anonymizer` (empties the value). Most delegate to a **Faker** generator exposed by the `anonymizer.faker` service (`FakerService`, wrapping `Faker\Factory`) — e.g. the email anonymizer returns `faker->unique()->safeEmail`, the username anonymizer `faker->unique()->userName`. A factory service `anonymizer.anonymizer_factory` (`AnonymizerFactory`) instantiates an anonymizer by id. The manager supports the `anonymizer_info` alter hook so other modules can add or change anonymizers. This submodule has no admin UI, routes, permissions, config or Drush of its own — it is a library consumed by GDPR Fields (which stores which anonymizer applies to a field), GDPR Dump (which anonymizes DB columns during export) and GDPR Tasks (right-to-be-forgotten). Requires only `system`; the parent GDPR project brings in `fakerphp/faker`.

---

- Provide the anonymization engine that GDPR Fields uses to scrub a personal-data field.
- Anonymize an email column in a database dump to a fake but valid `safeEmail`.
- Replace usernames with random Faker usernames during a right-to-be-forgotten run.
- Empty a sensitive field entirely using the `clear_anonymizer`.
- Generate fake free-text for a "notes"/"bio" field with `text_anonymizer` / `long_text_anonymizer`.
- Randomize a numeric field (e.g. an age or phone-as-number) with `number_anonymizer`.
- Anonymize a date field to a random date with `date_anonymizer`.
- Scramble a password/hash column with `password_anonymizer`.
- Replace a URL/URI value with a fake one via `uri_anonymizer`.
- Produce short random tokens with `random_text_anonymizer`.
- Add a custom anonymizer plugin (e.g. for phone numbers) via the `@Anonymizer` plugin type.
- Alter the set of available anonymizers with `hook_anonymizer_info_alter()` (`anonymizer_info`).
- Get a Faker generator anywhere via the `anonymizer.faker` service.
- Instantiate a specific anonymizer by id with the `anonymizer.anonymizer_factory` service.
- Ensure anonymized emails/usernames are unique via Faker's `unique()` modifier.
- Reuse the same anonymizers across dump, fields and tasks for consistent scrubbing.
- Pseudonymize user data for a sanitized staging/dev database.
- Provide GDPR-compliant test data by anonymizing real records.
- Swap in a locale-specific Faker output by decorating the faker service.
- Map a field's data type to an appropriate anonymizer in GDPR Fields.
- Build a bespoke anonymization strategy for a project-specific entity.
