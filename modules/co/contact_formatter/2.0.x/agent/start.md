<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Formatter — agent index

Provides one field formatter, **`contact_field_formatter`** ("Rendered Contact Form"), for
`entity_reference` fields. It renders the referenced core contact form inline as the field's
output. No settings form, no config schema, no permissions, no services, no Drush, no plugins
to implement. Depends on core `contact`.

- **Use the formatter: reference a contact form and render it inline** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `contact_field_formatter`, `field_types = { entity_reference }`, defined in
  `src/Plugin/Field/FieldFormatter/ContactFieldFormatter.php`.
- The entity-reference field must target the `contact_form` entity type.
- For each item it does `entityTypeManager->getStorage('contact_message')->create(['contact_form' => target_id])`,
  then `entity.form_builder->getForm($message)` and renders it.
- Personal contact forms are skipped (`$message->isPersonal()` is TRUE) — nothing is rendered.
- Formatter has empty `defaultSettings()`/`settingsForm()`/`settingsSummary()` — no options.
