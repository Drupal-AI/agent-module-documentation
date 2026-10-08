<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS entity, gateway & delivery

## Config entity `workflow_sms_notify`
`src/Entity/WorkflowSmsNotify.php` (`@ConfigEntityType`, base `WorkflowAbstractNotification`).
`config_prefix: workflow_sms_notify`; objects named `workflow_sms_notify.workflow_sms_notify.<id>`.
Handlers reuse the parent's `WorkflowNotificationControlHandler` (access), with the submodule's own
list builder and form.

Config keys (schema `config/schema/workflow_sms_notify.schema.yml`) match the mail entity except the
recipient field is `phone_num` (string, one number per line) instead of `mail_ids`; `subject` is
present in schema but the form removes it, and `message` (text_format) supplies the SMS text.
`config_export`: id, label, wid, from_sid, to_sid, when_to_trigger, days, roles, participate,
subject, message, phone_num.

## Recipient resolution
Inherited from `WorkflowAbstractNotification::sendMessages()` (explicit ids + role members + author +
`participate` filter). Two SMS-specific overrides:
- `getReceiverIds()` returns `$this->phone_num`.
- `getReceiverIdFromUser($user)` returns `\Drupal::service('sms.phone_number')
  ->getPhoneNumbers($user)` — **verified numbers only** (empty string when the user has none).

## Delivery — `WorkflowSmsNotify::send()`
```php
$smsProvider = \Drupal::service('sms.provider');
$sms_message = SmsMessage::create()->setMessage($params['message']);
$sms_message = SmsMessage::convertFromSmsMessage($sms_message)
  ->addRecipients($to)
  ->setDirection(Direction::OUTGOING);
\Drupal::service('sms.provider.default')->queue($sms_message);
```
No gateway is set on the message (the `setGateway()` line is commented out), so the SMS Framework's
**default gateway** — configured under the `sms` module, e.g. at `/admin/config/smsframework/gateways`
— performs the actual send. The whole send is wrapped in try/catch; any exception becomes a generic
"SMS not sent, please contact site administrator" messenger error. Only the message **body** is sent;
there is no subject for SMS.

## Routes (`workflow_sms_notify.routing.yml`)
Under `/admin/config/workflow/workflow/{workflow_type}/sms-notifications`, all `_admin_route: TRUE`:
- `entity.workflow_sms_notify.collection` — `_permission: 'administer workflow'`.
- `entity.workflow_sms_notify.add` — `_entity_create_access: 'workflow_notify'`.
- `entity.workflow_sms_notify.edit_form` — `_permission: 'administer workflow'`.
- `entity.workflow_sms_notify.delete_form` — `_permission: 'administer workflow'`.

`links.task.yml` adds **Mail** and **SMS** child tabs under the parent's notifications collection;
`links.action.yml` adds an **Add SMS Notification** action. No `permissions.yml` (reuses
`administer workflow`).

## Cron / queue / install
`workflow_sms_notify_cron()` mirrors the parent: once per day (State
`workflow_notifications.sms.last_run`) it queues `before_state_change`/`no_state_change` rules onto
`workflow_notifications.send`, delivered by the parent's `ScheduleMailQueue` worker (which calls
`sendMessages()` with `getDefaultTriggerId() = workflow_notification_before_sms_trigger`).
`workflow_sms_notify.install`: `update_8001` empty→`all` states; `update_1101` migrates the old
`workflow_sms_notify.settings:last_sms_run_date` config into the `workflow_notifications.sms.last_run`
State value.
