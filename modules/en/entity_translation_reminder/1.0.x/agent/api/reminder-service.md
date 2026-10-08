<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reminder mechanism — hook + ReminderService

## Entry point

`entity_translation_reminder.module` implements one hook:

- `entity_translation_reminder_entity_update(EntityInterface $entity)` →
  `\Drupal::service('entity_translation_reminder.reminder_service')->checkEntityAndShowReminder($entity)`.

Only `hook_entity_update` is implemented — the reminder fires on **entity save/update**, never on
insert (first creation) or delete. It applies to *every* content entity type saved on the site; the
filtering happens inside the service.

## Service

Defined in `entity_translation_reminder.services.yml` as
`entity_translation_reminder.reminder_service` →
`Drupal\entity_translation_reminder\Service\ReminderService`, constructor args `@messenger` and
`@config.factory`. Uses `StringTranslationTrait`.

### `checkEntityAndShowReminder(EntityInterface $entity): void`

Guard clauses (returns early, no message) in order:

1. Entity lacks `isTranslatable()` or `isTranslatable()` is FALSE.
2. Entity lacks `getTranslationLanguages()`.
3. `$entity->getTranslationLanguages(FALSE)` is empty — the `FALSE` **excludes the default
   language**, so the reminder only triggers when at least one *additional* translation exists.
4. The entity type is not enabled: `config('entity_translation_reminder.settings')->get('entity_types')`
   has no truthy entry for `$entity->getEntityTypeId()`.
5. The bundle is not enabled: `config->get('settings.' . $entity_type_id . '.' . $bundle)` is falsy.

If all pass, it builds `%title` from `$entity->toLink()->toString()` when `toLink()` exists (else
`$entity->label()`), then:

```
$reminder_message = $config->get('reminder_message')
  ?: $this->t('Remember to update all translations for %title.', ['%title' => $title_arg]);
$this->messenger->addWarning($reminder_message);
```

The message is a Drupal warning shown on the next page render. There is **no** staleness detection,
diffing of translation timestamps, cron, queue, email or logging — it is a one-shot on-screen prompt.

## Notes

- Because the type/bundle filter reads config, disabling an entity type or bundle on the settings
  form stops reminders immediately with no code change.
- The default message links to the saved entity; a custom `reminder_message` is shown verbatim and
  does not include the title link.
