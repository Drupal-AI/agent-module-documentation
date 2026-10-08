<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, route, permission & config

## Install / enable

Requires core `content_translation` (declared in `entity_translation_reminder.info.yml`). Enable with
`drush en entity_translation_reminder`. No library or Composer requirements.

## Route & menu

- Route `entity_translation_reminder.settings_page` (`entity_translation_reminder.routing.yml`):
  path `/admin/config/regional/entity-translation-reminder`, form
  `\Drupal\entity_translation_reminder\Form\EntityTranslationReminderConfigForm`,
  requirement `_permission: 'administer entity_translation_reminder'`.
- Menu link (`*.links.menu.yml`) under `system.admin_config_regional` (Configuration → Regional and
  language), weight 10. Local task tab (`*.links.task.yml`) titled *Settings*.
- `info.yml` sets `configure: entity_translation_reminder.settings_page`.

## Permission

`entity_translation_reminder.permissions.yml` defines one permission:
`administer entity_translation_reminder` (title *Administer Entity translation reminder*,
`restrict access: true`). It only guards the settings form; the reminder itself has no per-user gate.

## Config form — `EntityTranslationReminderConfigForm`

Extends `ConfigFormBase`; `getFormId()` = `entity_translation_reminder_settings_form`;
`getEditableConfigNames()` = `['entity_translation_reminder.settings']`. Constructor injects
`config.factory`, `config.typed`, `entity_type.manager`, `entity_type.bundle.info`.

`buildForm()` lists candidate entity types by iterating `entityTypeManager->getDefinitions()` and
keeping only those that are a `ContentEntityTypeInterface`, have a `langcode` key, have bundle info,
and are `isTranslatable()`. Elements:

- `entity_types` — `checkboxes` of the eligible entity type labels ("Enabled entity types").
- `reminder_message` — required `textarea` for the message text.
- `settings` (`#tree = TRUE`) — a `details` group per enabled entity type (shown via `#states` when
  its type checkbox is ticked), containing a `checkbox` per **translatable** bundle
  (`$bundle_info['translatable']`); a "No translatable bundles found" note if none.

`submitForm()` saves `entity_types`, `settings`, and `reminder_message` into the config object.

## Config object & schema

`config/install/entity_translation_reminder.settings.yml` defaults:

```
entity_types: {}
settings: {}
reminder_message: 'Remember to update all translations.'
```

Schema (`config/schema/entity_translation_reminder.schema.yml`), type `config_object`:

- `entity_types` — `sequence` of `boolean` (entity-type-id → enabled).
- `settings` — `sequence` of `sequence` of `boolean` (entity-type-id → bundle → enabled).
- `reminder_message` — `text`.

`entity_translation_reminder.config_translation.yml` registers the config object for the
Configuration Translation UI (translatable per interface language).
