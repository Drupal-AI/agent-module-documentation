# Moderation Note — agent index

In-context editorial notes on moderated entities: select text in a field, attach a threaded,
assignable, resolvable note shown in an off-canvas sidebar. Requires core `content_moderation` +
`user`. Config page `/admin/config/moderation-note` (`moderation_note.settings`, permission
`administer moderation notes`). No Drush; provides a config schema.

- **The 7 permissions and the exact access model (who can view/create/edit/resolve notes)** →
  [permissions/permissions.md](permissions/permissions.md)
- **The one setting (email on/off) + the notification behavior and mail template** →
  [configure/settings.md](configure/settings.md)
- **The `moderation_note` entity, routes/controller, Ajax, Views field, assignee selection** →
  [api/notes.md](api/notes.md)

Key facts:
- Entity `moderation_note` (base_table `moderation_note`, `admin_permission` = `administer
  moderation notes`, publishable, not fieldable). Fields include `uid`, `parent`, `assignee`,
  `entity_type`/`entity_id`/`entity_field_name`/`entity_langcode`/`entity_view_mode_id`, `quote`,
  `quote_offset`, `text`.
- Access (see permissions doc) is tied to view/update access of the **moderated** entity, not just
  the permission — view a note ⇒ needs `access moderation notes` AND view access to the target.
- Routes: create/view/edit/delete/resolve/reply per note, plus `moderation_note.list` and
  `moderation_note.assigned_list` (`/user/{user}/moderation-notes`). Controller returns AJAX/off-canvas.
- Setting `moderation_note.settings.send_email` (default `true`). Mail plugin `NoteMail`; template
  `templates/mail-moderation-note.html.twig`.
