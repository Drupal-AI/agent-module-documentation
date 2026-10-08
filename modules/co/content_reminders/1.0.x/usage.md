<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Reminders and Notifications schedules cron-driven email reminders about individual nodes to one or more recipients.

---

The module defines a `content_reminder` config entity that stores a node id, comma-separated recipient emails, a send date/time (stored as a Unix timestamp) and an optional message. Reminders are created two ways: from a dedicated admin UI at `/admin/structure/content_reminder` (list, add, edit, delete, preview), or inline through a "Content Reminder" fieldset that `hook_form_alter` adds to the edit form of any node whose content type has been enabled on the settings form at `/admin/config/development/content_reminders`. On each `hook_cron` run the module loads every enabled reminder whose date/time is at or before now, sends the recipients an email containing a link to the node and the message (built in `hook_mail`), logs the result, then sets the reminder's status to disabled so it fires only once. Deleting a node deletes its reminders. It requires no contrib dependencies (only core node and the mail system) and gates all of its routes behind either `administer content reminder` or `administer site configuration`.

---

- Email a content author to review or refresh an aging article on a set date.
- Schedule a one-time reminder about a specific node from that node's edit form.
- Manage all reminders centrally from the `/admin/structure/content_reminder` collection list.
- Send a reminder to several people at once via a comma-separated email list.
- Attach an optional custom message/note to a reminder email.
- Restrict which content types can carry an inline reminder fieldset via the settings form.
- Preview a saved reminder's fields (label, status, node, emails, date/time, message) before it fires.
- Fire reminders automatically on cron with no manual sending step.
- Ensure each reminder sends only once (it disables itself after a successful send).
- Automatically clean up a node's reminders when the node is deleted.
- Remind an editorial team to check that time-sensitive content is still accurate.
- Notify authors about scheduled unpublish/review deadlines for their content.
- Track content that must be kept fresh (blog posts, news, landing pages).
- Create a reminder addressed to a shared editorial mailbox.
- Enable or disable an individual reminder without deleting it.
- Edit a reminder's recipients, date/time or message after creation.
- Delete a reminder that is no longer needed.
- Give a specific role reminder-management rights through the `administer content reminder` permission.
- Use the default site email as the reminder's From address.
- Include a direct link back to the reminded node in the notification email.
- Run entirely on Drupal core with no external service or API key.
