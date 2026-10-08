<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `workflow_notify` config entity

Defined by `src/Entity/WorkflowNotification.php` (`@ConfigEntityType`, base class
`WorkflowAbstractNotification`).

- **id:** `workflow_notify` · **config_prefix:** `workflow_notify`
  (config objects named `workflow_notifications.workflow_notify.<id>`).
- **Handlers:** access = `WorkflowNotificationControlHandler`; list_builder =
  `Controller\WorkflowNotificationListBuilder`; forms add/edit = `Form\WorkflowNotificationForm`,
  delete = core `EntityDeleteForm`.
- **Links:** edit / delete / collection under
  `/admin/config/workflow/workflow/{workflow_type}/notifications/…`.

## Config keys (config_export + schema)
Schema: `config/schema/workflow_notifications.schema.yml` (`workflow_notifications.workflow_notify.*`).

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string | Machine name. |
| `label` | string | Admin label. |
| `wid` | string | Workflow type id this rule belongs to. |
| `from_sid` | string | Source state id, or `'all'` = any. Default `''`. |
| `to_sid` | string | Target state id, or `'all'` = any. Default `''`. |
| `when_to_trigger` | string | `on_state_change` (default) / `before_state_change` / `no_state_change`. |
| `days` | integer | Days offset for the scheduled/idle triggers; forced to 0 for `on_state_change`. |
| `roles` | sequence | Role ids whose active members receive the message. |
| `participate` | boolean | Only send to users who participated in this entity's transitions. |
| `mail_ids` | string | Explicit recipient email addresses, one per line (`\r\n`), token-aware. |
| `subject` | string | Message subject (token-aware). |
| `message` | text_format | Rich-text body (`{value, format}`, default format `basic_html`), token-aware. |

`entity_keys` also expose `mail_to` (mail entity) but it is not part of `config_export`.
The property `message` defaults to `['value' => '', 'format' => 'basic_html']`.

## Entity behaviour
- `WorkflowAbstractNotification::save()` zeroes `days` when trigger is `on_state_change` and
  `array_filter($this->roles)` (drops unchecked roles) before `parent::save()`.
- `getReceiverIds()` returns `$this->mail_ids` (SMS subclass returns `phone_num` instead).
- `getReceiverIdFromUser($user)` returns `$user->getEmail()`.
- `getDefaultTriggerId()` returns `workflow_notification_before_mail_trigger` (used as the mail key
  for queued deliveries).
- `toUrl()` injects `workflow_type` (= `getWorkflowId()`) and `workflow_notify` route parameters.

## Install / updates
`workflow_notifications.install`: `update_8001` migrates empty `from_sid`/`to_sid` to `'all'`;
`update_1101` moves the old `workflow_notifications.last_run` State value to
`workflow_notifications.mail.last_run`. No `hook_install`/`hook_schema` (config entity only).
