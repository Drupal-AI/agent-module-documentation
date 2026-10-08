<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow SMS Notification (workflow_sms_notify) — agent index

Submodule of **workflow_notifications**. Delivers an **SMS** (instead of email) on the same Workflow
state transitions, using the core **SMS Framework** (`sms:sms`) and whatever SMS gateway that module
already has configured. Each rule is a `workflow_sms_notify` **config entity**.

- **Version:** 3.0.2. **Core:** `^8.8 || ^9 || ^10 || ^11.2`. **Package:** Workflow.
- **Depends on:** `workflow:workflow`, `sms:sms` (SMS Framework), `workflow_notifications`.
  Composer: `drupal/sms:^2.0`, `drupal/workflow:^2.1`, `drupal/workflow_notifications:^2.0`.
- **Manage at:** `/admin/config/workflow/workflow/{workflow_type}/sms-notifications`
  (an **SMS** tab beside the parent's **Mail** tab).

## What it adds on top of the parent
- `Entity/WorkflowSmsNotify` — its own `@ConfigEntityType` (`config_prefix: workflow_sms_notify`),
  extending `WorkflowAbstractNotification`. Adds a `phone_num` field in place of `mail_ids`;
  `getReceiverIds()` returns `phone_num`; `getReceiverIdFromUser()` returns the user's **verified**
  phone numbers via `sms.phone_number`.
- `send()` builds an `SmsMessage` (message body only, direction OUTGOING) and hands it to
  `sms.provider.default->queue()` — no gateway is set explicitly, so the SMS Framework's default
  gateway is used. Failures are caught and surfaced as a generic messenger error.
- `Form/WorkflowSmsNotificationForm` extends the mail form, swapping `mail_ids`/`subject` for a
  `phone_num` textarea (one number per line).
- `Controller/WorkflowSmsNotificationListBuilder` extends the parent list builder unchanged.
- `hook_entity_insert/update` + `hook_cron` mirror the parent (medium `sms`, State
  `workflow_notifications.sms.last_run`), reusing the shared `workflow_notifications.send` queue and
  the parent's `ScheduleMailQueue` worker. Default trigger id: `workflow_notification_before_sms_trigger`.

## Solution doc
- [Entity, gateway & delivery](api/sms-delivery.md) — config keys, routes/permissions, how a number
  is resolved and how the message is queued to the SMS gateway.

Reuses the parent's access handler, abstract entity, token replacement, and recipient/role logic —
see the parent module's `agent/api/triggering-and-delivery.md`.
