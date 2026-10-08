<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity translation reminder (entity_translation_reminder) — agent index

Shows a **warning message** to the editor when a **translated content entity is updated**, reminding
them to update all its translations. Package `Multilingual`. Depends on core **`content_translation`**.
Core `^10.3 || ^11.0`. License GPL-2.0-or-later. Version 1.0.0-rc4 (version-dir 1.0.x).

- **The reminder mechanism (hook + service, detection logic)** → [api/reminder-service.md](api/reminder-service.md)
- **Settings form, config object/schema, route & permission** → [config/settings.md](config/settings.md)

## What it actually is

- One hook: `entity_translation_reminder_entity_update()` in `entity_translation_reminder.module`,
  which calls the service `entity_translation_reminder.reminder_service`.
- One service: `ReminderService` (`src/Service/ReminderService.php`), args `@messenger`,
  `@config.factory`. Method `checkEntityAndShowReminder(EntityInterface $entity)`.
- One config form: `EntityTranslationReminderConfigForm` (`src/Form/…`), route
  `entity_translation_reminder.settings_page` at `/admin/config/regional/entity-translation-reminder`,
  permission `administer entity_translation_reminder`.
- One config object: `entity_translation_reminder.settings` (`entity_types`, `settings`,
  `reminder_message`), with schema and config-translation support.
- **No** report/dashboard route, **no** cron, **no** email/notification, **no** entity/field/plugin,
  **no** Drush. It fires only on entity **update** (not insert).

## Mechanism (from source)

- On `hook_entity_update`, `checkEntityAndShowReminder()` returns early unless the entity
  `isTranslatable()`, has ≥1 translation via `getTranslationLanguages(FALSE)` (excludes the default
  language), and both the entity type (`config.entity_types[<type>]`) and bundle
  (`config.settings.<type>.<bundle>`) are enabled.
- If enabled, it adds a **warning** via `messenger->addWarning()`: the configured `reminder_message`,
  or a default `t('Remember to update all translations for %title.')` where `%title` is
  `entity->toLink()->toString()` (or `label()`). No staleness computation — it reminds on every
  qualifying update.
