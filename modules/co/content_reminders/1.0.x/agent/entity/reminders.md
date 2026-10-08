<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# content_reminder entity, service, cron send

## The config entity

`src/Entity/ContentReminder.php` — `@ConfigEntityType(id = "content_reminder")`,
`config_prefix = "content_reminder"`, `admin_permission = "administer content reminder"`.
`config_export`: `id`, `label`, `nid`, `emails`, `date_time`, `message` (note: `status` is a
runtime flag, not exported). Implements `ContentReminderInterface` with getters/setters:
`getNodeId()/setNodeId()`, `getEmails()/setEmails()` (a comma-separated string, not an array),
`getDateTime()` (returns the stored Unix timestamp) / `setDateTime(DrupalDateTime)` (stores
`->getTimestamp()`), `getMessage()/setMessage()`. Config schema `content_reminders.content_reminder.*`
in `config/schema/content_reminders.schema.yml` (`emails` typed as a `sequence` of strings there,
while the entity stores/handles it as a single string).

Handlers: `list_builder` = `ContentReminderListBuilder`; forms `add`/`edit` = `ContentReminderForm`,
`delete` = core `EntityDeleteForm`.

## Routes & permissions (`content_reminders.routing.yml`)

All entity routes require `administer content reminder`:

- `entity.content_reminder.collection` — `/admin/structure/content_reminder` (`_entity_list`).
- `entity.content_reminder.add_form` — `/admin/structure/content_reminder/add`.
- `entity.content_reminder.edit_form` — `/admin/structure/content_reminder/{content_reminder}`.
- `entity.content_reminder.delete_form` — `/admin/structure/content_reminder/{content_reminder}/delete`.
- `entity.content_reminder.preview_page` — `/…/{content_reminder}/preview`
  → `ContentReminderController::preview()`, renders an `item_list` of label/id/status/nid/emails/
  date-time/message. (The settings route `content_reminders.form` requires `administer site
  configuration` — see config/settings.md.)

Menu link `entity.content_reminder.overview` (under *Structure*) → collection; local action
`entity.content_reminder.add_form` on the collection. `administer content reminder` is defined in
`content_reminders.permissions.yml`.

## Standalone add/edit form

`src/Form/ContentReminderForm.php` (`EntityForm`) builds: `label` (required), `id`
(`machine_name`, exists → `ContentReminder::load`), `status` (checkbox), `nid`
(`entity_autocomplete`, `target_type = node`, required), `emails` (textfield, required,
"separated by a comma"), `date_time` (`datetime`, required), `message` (textarea, optional).
`save()` re-stores the datetime via `setDateTime()`, saves, sets a status message and redirects to
the collection. `ContentReminderListBuilder` shows label, node link, status, nid, emails, date/time,
message columns and adds a **Preview** operation.

## Inline fieldset on node forms (service)

`content_reminders.services.yml` registers `content_reminders.content_reminder` →
`ContentReminderService` (arg: `@entity_type.manager`). `hook_form_alter` in
`content_reminders.module` fires for any `EntityForm` whose bundle is in
`content_reminders.settings:content_types`, that has an entity id, and whose operation is not
`delete/cancel/reset/layout_builder/replicate`; it calls
`ContentReminderService::addReminderToEntityForm()`.

- That method adds a `content_reminder` `details` group (`#group => 'advanced'`) with `cr_nid`
  (hidden), `cr_emails`, `cr_date_time`, `cr_message`, and a `cr_save` submit button whose `#ajax`
  callback is the procedural `_content_reminders_save()` (module file), which delegates to
  `ContentReminderService::handleFormSubmit()`.
- `handleFormSubmit()` finds an existing reminder for the node via `getContentReminderFor($nid)`
  (an entity query on `nid` with `accessCheck(FALSE)` — an internal lookup, no route exposure) or
  creates one with `id = "{nid}_content_reminder"` and `label = "{nid} content reminder"`, sets
  `status = 1`, emails, date/time and message, saves, and returns an `AjaxResponse` replacing
  `#cr_output` with a "Content Reminder Saved" message. The reminder saves independently of the
  node save (AJAX), so the fieldset only appears on **existing** entities.

## Sending: hook_cron + hook_mail

`content_reminders_cron()`: entity query for reminders with `date_time <= time()` **and**
`status == TRUE`; for each, loads the node label, builds an HTML body with a `/node/{nid}` link and
the reminder message, and calls `mail.manager->mail('content_reminders', 'content_reminder', $to,
$langcode, $params)` where `$to = $entity->getEmails()` (the comma-separated string) and `$langcode`
is the site default language. On success it logs a notice and calls `setStatus(FALSE)` + `save()`
so the reminder fires only once; on failure it logs an error and returns.

`content_reminders_mail()` (key `content_reminder`): `from` = `system.site:mail`;
`subject` = "You have a content reminder for @title (node: @nid)"; body = the prepared HTML message.

## Lifecycle cleanup

`content_reminders_entity_delete()`: when a `NodeInterface` is deleted, it entity-queries
`content_reminder` by `nid` and deletes matches via `_content_reminders_delete_reminders()`.

## Notes

- `emails` is a single comma-separated string end-to-end; there is no per-address validation or
  parsing into an array — whatever is entered is passed straight to the mail manager's `$to`.
- Cron sends all due reminders in one run; a reminder set far in the past that is still enabled will
  send on the next cron. `date_time` is a plain timestamp with no recurrence.
- `hook_preprocess_html` only attaches `content_reminders/content_reminders` (CSS in
  `css/content-reminders.css`) when the active theme is `adminimal_theme`.
