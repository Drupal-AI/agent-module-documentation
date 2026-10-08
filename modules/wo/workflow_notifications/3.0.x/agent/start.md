<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Notifications (workflow_notifications) — agent index

Sends messages when a **Workflow** module state transition occurs. Each rule is a
`workflow_notify` **config entity** describing which transition it responds to, who receives it,
and the subject/body. Managed per workflow type at
`/admin/config/workflow/workflow/{workflow_type}/notifications`.

- **Version:** 3.0.2. **Core:** `^8.8 || ^9 || ^10 || ^11.2`. **Package:** Workflow.
- **Depends on:** `workflow:workflow` (`drupal/workflow:^2.1`). Optional `token` module enriches the form.
- **Configure route:** `entity.workflow_type.collection` (a "Notifications" task tab is added there).
- **Provides:** config entity `workflow_notify`; a QueueWorker plugin; token type `workflow_state`.
- **No permissions.yml** — it reuses Workflow's `administer workflow` permission.

## How it works (one line each)
- `hook_entity_insert` / `hook_entity_update` (`workflow_notifications.module`) detect a transition
  via `_workflow_notifications_get_transition_details()`, load matching `workflow_notify` rules with
  `WorkflowNotification::loadMultipleByProperties()`, and call `->sendMessages($trigger, $transition)`.
- `hook_cron` queues `before_state_change` / `no_state_change` rules once per day onto the
  `workflow_notifications.send` queue; the `ScheduleMailQueue` QueueWorker delivers them.
- `WorkflowAbstractNotification::sendMessages()` does token replacement, resolves recipients
  (explicit ids + role members + author + participation filter), and defers to a subclass `send()`.
- `WorkflowNotification::send()` calls core `plugin.manager.mail`; `hook_mail()` sets an HTML body.

## Classes / files
- `Entity/WorkflowNotification` — the `@ConfigEntityType` (`config_prefix: workflow_notify`); mail-specific `mail_ids` + `send()`.
- `Entity/WorkflowAbstractNotification` — shared base: query, recipient resolution, token replace.
- `Entity/WorkflowNotificationInterface` — the contract (`getWorkflow*`, `loadMultipleByProperties`, `sendMessages`).
- `WorkflowNotificationControlHandler` — entity access handler.
- `Form/WorkflowNotificationForm` — add/edit form (trigger, recipients, message, tokens).
- `Controller/WorkflowNotificationListBuilder` — the per-workflow collection list.
- `Plugin/QueueWorker/ScheduleMailQueue` — cron delivery of scheduled/idle rules.
- `workflow_notifications.tokens.inc` — `workflow_state` token type + field-property token replacement.

## Solution docs
- [Config entity & fields](config/notification-entity.md) — the `workflow_notify` entity, config keys, schema.
- [Triggers, recipients & delivery](api/triggering-and-delivery.md) — hooks, cron/queue, token replacement, who gets notified.
- [Routes, forms & access](config/routes-and-access.md) — routes, the form, permissions, list builder.

## Submodule
- **`workflow_sms_notify`** — same transitions, delivered as SMS via the core **SMS Framework**
  (`sms:sms`). Documented in its own tree under `modules/workflow_sms_notify/3.0.x/`.
