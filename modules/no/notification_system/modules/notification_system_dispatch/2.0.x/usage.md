<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification System Dispatch sends notifications out of Drupal through pluggable delivery channels, with per-user preferences and optional batching.

---

Where the core framework only gathers and displays notifications, this submodule delivers them. It defines a `notification_system_dispatcher` plugin type — a delivery channel such as email or web push — and wires the framework's NewNotificationEvent into a queue-backed pipeline. When a new notification appears, an event subscriber decides, per audience user, whether to dispatch immediately (queue a job now) or to accumulate the notification into that user's `notification_dispatch_bundle` entity for a daily or weekly summary. During cron, bundles that are due are flushed to the queue and a queue worker instantiates each enabled channel and calls its `dispatch()` with the user and their notifications. Users control their own delivery through a `UserSettingsService` (stored in `user.data`): which channels they receive, which notification groups per channel, and — when bundling is enabled — their send mode. Site administrators set the defaults: default channels, default send mode, whether bundling is offered, an optional whitelist for testing, and a "forced dispatcher" that critical (forced) notifications always reach regardless of user opt-outs. The concrete channels ship as separate submodules (mail, web push), and adding a new one — Slack, Teams, SMS — is just another dispatcher plugin.

---

- Deliver notifications by email, web push, or a custom channel.
- Add a new delivery channel as a notification_system_dispatcher plugin.
- Let each user turn individual channels on or off.
- Let each user choose which notification groups they receive per channel.
- Offer immediate, daily-summary, or weekly-summary delivery.
- Bundle a user's notifications into one periodic digest.
- Queue delivery so heavy sends happen in the background during cron.
- Force critical notifications to a chosen channel, bypassing user opt-outs.
- Set which channels are enabled by default for new users.
- Restrict delivery to a whitelist of users while testing.
- React automatically to any new notification via the framework event.
- Surface a user notification-preferences form as a block.
- Autosave preference changes over AJAX as the user toggles them.
- Store per-user preferences in user.data (no extra entity per preference).
- Clean up a user's pending bundle when their account is removed.
- Drive delivery entirely from saving a notification entity.
- Combine multiple channels so one notification reaches a user several ways.
