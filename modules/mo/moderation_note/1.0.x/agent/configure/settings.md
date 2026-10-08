# Configure — settings & email notifications

## Setting
Route `moderation_note.settings` → `/admin/config/moderation-note` (permission
`administer moderation notes`). Config object `moderation_note.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `send_email` | boolean | `true` | Master switch for all note email notifications. |

```
ddev drush cset moderation_note.settings send_email 0 -y   # disable all note emails
```

## Setup prerequisites
- Enable `content_moderation` and configure a workflow on the target entity types/bundles; notes
  attach to the **latest revision** of moderated entities.
- The note "Add note" affordance appears on rendered fields when the viewer passes
  `_moderation_note_on_entity` (see permissions doc). Grant editorial roles `view latest version`
  (and usually `view any unpublished content`) so they can reach Draft revisions to annotate.

## Email notifications (when `send_email` is true)
Sent via the `NoteMail` mail plugin, rendered from `templates/mail-moderation-note.html.twig`
(override in your theme to customize). Recipients by event:
- **Create** — the moderated entity's creator and last-updater.
- **Assign** — the assignee.
- **Resolve / re-open / reply** — the entity creator & last-updater, the assignee (if any), and all
  users who replied to the note.
- **Delete** — no email (resolve notification already covered it).

No other configuration; the entity type is not fieldable and has no bundles.
