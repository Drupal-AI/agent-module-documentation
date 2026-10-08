# Configure — bulk actions, admin view, settings

## The bulk moderation actions

The module defines five `ActionBase` plugins (in `src/Plugin/Action/`), each `type = "node"`,
`confirm = TRUE`, and delegating to the `AdminModeration` / `AdminPin` helpers:

| Action plugin id | Does | Permission checked |
|---|---|---|
| `publish_latest_revision_action` | Publishes the latest (pending) revision; verifies a real published default revision results | `moderated content bulk publish` |
| `unpublish_current_revision_action` | Moves current revision to an unpublished state | `moderated content bulk unpublish` |
| `archive_current_revision_action` | Moves current revision to the archived state | `moderated content bulk archive` |
| `pin_content_action` | Sets nodes sticky (pinned) | `moderated content bulk pin content` |
| `unpin_content_action` | Removes sticky | `moderated content bulk unpin content` |

Transitions are **translation-aware**: the helpers iterate every translation of the node
(`hasTranslation`/`getTranslation`) and apply the moderation state per language. Actions act
on moderated entities via `content_moderation.moderation_information` (checking
`moderation_state` field access), and also work on `media` entities.

These are shipped as **optional** config (`config/optional/system.action.*.yml`) so they only
install when their dependencies are met: `publish_latest`, `unpublish_current`,
`archive_current`, `pin`, `unpin` (node) plus `media_publish_latest`,
`media_unpublish_current` (media).

## Enabling on the admin content view

Per the README, edit the content view (`/admin/structure/views/view/content`), add the
**"Node operations bulk"** field, and enable these operations:

- Pin Content
- Publish latest revision
- Unpin content
- Unpublish current revision
- Archive current revision

Then on `/admin/content` select rows and choose an action. Views Bulk Operations drives the
selection and batch.

## Settings form

Route `moderated_content_bulk_publish.settings.form` at
`/admin/config/content/moderated-content-bulk-publish` (permission `administer site
configuration`). Config object: `moderated_content_bulk_publish.settings`.

| Key | Type | Default | Effect |
|---|---|---|---|
| `enable_dialog_admin_content` | bool | `true` | JS confirmation dialog before bulk ops on the admin listing |
| `enable_dialog_node_edit_form` | bool | `true` | Confirmation dialog when publishing from a node form |
| `disable_toolbar_language_switcher` | bool | `false` | Hide the admin-toolbar language switcher (multilingual sites) |
| `retain_revision_info` | bool | `false` | Keep original revision authoring info; append bulk context to the revision log |
| `publish.state.published` | string | `published` | Which workflow state the publish action targets |
| `unpublish.state.archived` / `unpublish.state.draft` | string | `archived` / `draft` | States treated as "unpublished" |
| `archive.state.archived` | string | `archived` | State the archive action targets |

Config schema is in `config/schema/moderated_content_bulk_publish.schema.yml`. Example:

```
drush cset moderated_content_bulk_publish.settings enable_dialog_admin_content 0 -y
```

An event subscriber (`HandlerFor403AccessDenied`) prevents a 403 when a translation has no
latest revision by redirecting to the node, which then renders correctly.
