<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, form & access

## Routes (`workflow_notifications.routing.yml`)
All are `_admin_route: TRUE` and take the `{workflow_type}` (upcast to `entity:workflow_type`) plus,
where relevant, the `{workflow_notify}` config entity.

| Route | Path (under `/admin/config/workflow/workflow/{workflow_type}/notifications`) | Requirement |
|-------|------|-------------|
| `entity.workflow_notify.collection` | `` (base) | `_permission: 'administer workflow'` |
| `entity.workflow_notify.add` | `/add` | `_entity_create_access: 'workflow_notify'` |
| `entity.workflow_notify.edit_form` | `/{workflow_notify}/edit` | `_entity_access: 'workflow_notify.update'` |
| `entity.workflow_notify.delete_form` | `/{workflow_notify}/delete` | `_entity_access: 'workflow_notify.delete'` **and** `_permission: 'administer workflow'` |

Menu wiring: `links.task.yml` adds a **Notifications** local task to `entity.workflow_type.edit_form`;
`links.action.yml` adds an **Add Mail Notification** action on the collection.

## Permissions
The module ships **no** `permissions.yml`. It reuses the Workflow module's `administer workflow`
permission. `checkCreateAccess()` in `WorkflowNotificationControlHandler` requires
`administer workflow`; the collection and delete routes require it directly.

## Access handler
`src/WorkflowNotificationControlHandler.php` extends `EntityAccessControlHandler`:
- `checkCreateAccess()` → `AccessResult::allowedIfHasPermission($account, 'administer workflow')`.
- `access()` handles the `update`/`delete` operations and otherwise defers to the parent handler.

## Add/edit form (`Form/WorkflowNotificationForm`)
`EntityForm` with services `module_handler`, `token`, `email.validator`. Fields, grouped into
`details` sections:
- **Trigger:** `from_sid`, `to_sid` (both offering "Any State" = `all`), `when_to_trigger` (radios
  from `workflow_notifications_get_trigger_values()`), and `days` (hidden for `on_state_change`).
- **Mail To:** `roles` (checkboxes, anonymous removed, required), `mail_ids` (textarea, one address
  per line), `participate` (checkbox).
- **Message:** `subject` (required), `message` (`text_format`, required).
- **Tokens:** a `token_tree_link` browser when the `token` module is enabled.

`validateForm()` validates each non-token `mail_ids` entry with `email.validator` (skipped when the
value contains tokens). `save()` shows a status message and redirects to the collection. The SMS
submodule's form subclasses this one, swapping `mail_ids`/`subject` for a `phone_num` field.

## List builder
`Controller/WorkflowNotificationListBuilder` (extends `ConfigEntityListBuilder`) adds Label /
From State / To State / When-To-Trigger columns, resolves state ids to labels via
`workflow_allowed_workflow_state_names()`, and only lists rules for the current workflow
(`workflow_url_get_workflow()`).
