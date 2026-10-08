# Configure — content_moderation_notifications

Configuration lives entirely in **`content_moderation_notification`** config entities (one per
notification). There is no global settings form.

## Admin UI / routes (from `content_moderation_notifications.routing.yml`)

| Route | Path | Purpose |
|---|---|---|
| `entity.content_moderation_notification.collection` | `/admin/config/workflow/notifications` | List all notifications. **This is the `configure` route.** |
| `entity.content_moderation_notification.add_form` | `/admin/config/workflow/notifications/add` | Add |
| `entity.content_moderation_notification.edit_form` | `/admin/config/workflow/notifications/manage/{id}` | Edit |
| `entity.content_moderation_notification.delete_form` | `.../manage/{id}/delete` | Delete |
| `entity.content_moderation_notification.enable_form` | `.../manage/{id}/enable` | Enable |
| `entity.content_moderation_notification.disable_form` | `.../manage/{id}/disable` | Disable |

Menu: Administration → Configuration → Workflow → Content Moderation Notifications.
The collection is gated by the `administer content moderation notifications` permission; add/edit/etc.
use entity access. Enable/disable also appear as row operations on the collection list.

## Config entity: `content_moderation_notification`

Config prefix `content_moderation_notifications.content_moderation_notification.{id}`.
Exported keys (from the entity `config_export` + schema):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name |
| `label` | label | Human name |
| `workflow` | string | Workflow ID this notification is scoped to (required) |
| `transitions` | sequence of string | Transition IDs (of that workflow) that trigger it |
| `roles` | sequence of string | Role IDs; every active user in the role that can `view` the entity is emailed |
| `author` | boolean | Also email the entity author (owner) |
| `site_mail` | boolean | **Disable** site mail: `TRUE` = do NOT use the site address as the visible recipient |
| `emails` | string | Ad-hoc addresses; comma- and newline-separated; Twig-rendered |
| `user_fields` | sequence of string | Entity-reference user fields in `{entity_type}:{field_name}` form; their referenced users are emailed |
| `subject` | label | Email subject; supports tokens + inline Twig |
| `body` | text_format | Email body `{value, format}`; Twig-rendered then run through the format's filters |
| `status` | boolean | Enabled/disabled (only enabled ones fire) |

Notes:
- A notification fires only when the saved moderated entity's detected transition ID is in
  `transitions` AND `status` is 1 AND `workflow` matches the entity's workflow.
- On save, empty values in `roles`, `transitions`, and `user_fields` are filtered out.
- Config schema is provided (`config/schema/content_moderation_notifications.schema.yml`), so
  notifications are fully exportable/importable.

## Twig / tokens in subject & body

Subject, body, and the ad-hoc `emails` field are rendered as inline Twig with context
`{ entity, user, <entity_type> => entity }` before token replacement. Handy variables:
`{{ entity.title }}`, `{{ entity.bundle }}`, `{{ entity.owner.email }}`,
`{{ entity.owner.accountname }}`, `{{ user.email }}`. Ad-hoc emails can be produced with Twig, e.g.
`{{ entity.field_department.entity.field_manager_email.0.value }}`. See
[../api/content_moderation_notifications.md](../api/content_moderation_notifications.md) for the
module's own tokens (`workflow`, `from-state`, `to-state`).

## Drush

Create/manage notifications as ordinary config entities:
`drush config:get content_moderation_notifications.content_moderation_notification.{id}` and
`drush config:set …` / config import-export. The module ships **no** custom Drush commands.
