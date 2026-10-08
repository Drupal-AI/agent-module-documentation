<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Translation Reminder shows a warning message to editors when they update a content entity that already has translations, reminding them to update all of its translations too.

---

The module is deliberately small. It implements `hook_entity_update()` and, through its `ReminderService`, checks each saved entity: if the entity is translatable, already has at least one non-default translation, and its entity type **and** bundle have been enabled on the module's settings form, it adds a warning message via Drupal's messenger. The message text is a configurable string (default *"Remember to update all translations."*), or a built-in message that includes a link to the saved entity when no custom text is set. There is no report, dashboard, cron job, email or notification, and no staleness tracking: the reminder is shown every time an already-translated entity of an enabled bundle is updated, purely as an on-screen prompt for the editor doing the save. Administrators choose which translatable entity types and bundles trigger the reminder at **Configuration → Regional and language → Entity translation reminder settings** (`/admin/config/regional/entity-translation-reminder`), gated by the `administer entity_translation_reminder` permission. Settings are stored in the `entity_translation_reminder.settings` config object and the reminder message is config-translation aware. It requires core's Content Translation module.

---

- Remind editors to update the other translations whenever they edit an already-translated node.
- Show the reminder only for chosen content types (e.g. only Articles, not Pages).
- Enable reminders per entity type and bundle from a single settings form.
- Cover any translatable content entity type — nodes, taxonomy terms, media, custom entities — not just nodes.
- Turn reminders on for media entities so translated media metadata stays in sync.
- Turn reminders on for taxonomy terms so translated term names/descriptions are kept current.
- Customize the reminder wording to match your editorial voice or house style.
- Provide a translated reminder message per interface language via config translation.
- Prompt editors right on the page they just saved, without leaving the edit workflow.
- Reduce the number of source edits that silently leave stale translations behind.
- Use it as a lightweight nudge in an editorial process instead of a heavyweight translation-workflow module.
- Limit the reminder to bundles that are actually configured translatable (non-translatable bundles are skipped automatically).
- Avoid noise on brand-new content: the reminder fires on updates of entities that already have translations, not on first creation of an untranslated entity.
- Roll the feature out gradually by enabling one entity type at a time.
- Give multilingual teams a consistent, site-wide reminder rather than relying on individual editors to remember.
- Pair with core Content Translation to reinforce good translation hygiene.
- Ship the configuration as part of a site's exported config so all environments behave the same.
- Keep the default message but link editors straight to the entity that needs its translations refreshed.
- Disable the reminder for an entity type simply by unchecking it, with no code changes.
- Restrict who can change the reminder configuration through a dedicated administration permission.
