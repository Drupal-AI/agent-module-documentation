<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymizer — agent index

Defines an **Anonymizer plugin type** and ten built-in anonymizers that turn a value into
anonymized/fake data (via Faker). A library used by `gdpr_fields`, `gdpr_dump`, `gdpr_tasks`.
No UI, routes, permissions, config or Drush. Requires `system`.

- **The plugin type, the built-in anonymizer ids, the services, and how to add one** →
  [plugins/anonymizers.md](plugins/anonymizers.md)

Key facts:
- Plugin manager service: `plugin.manager.anonymizer` (namespace `Plugin/Anonymizer`,
  annotation `@Anonymizer`, interface `AnonymizerInterface`, base `AnonymizerBase`).
- Built-in ids: `email_anonymizer`, `username_anonymizer`, `text_anonymizer`,
  `long_text_anonymizer`, `random_text_anonymizer`, `number_anonymizer`, `date_anonymizer`,
  `password_anonymizer`, `uri_anonymizer`, `clear_anonymizer`.
- Faker service: `anonymizer.faker`; factory: `anonymizer.anonymizer_factory`.
- Alter hook `anonymizer_info` to add/modify anonymizers.
