<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toasty provides a toast-style notification UI for Drupal messages, delivered in real time through the Pusher service.
---
The module hooks into Drupal's Messenger via a middleware (`ToastyPostHandleMiddleware`, `messenger.middleware.toasty_post_handle`) so that queued status/warning/error messages can be presented as toast notifications rather than the default message area. It depends on `pusher_mini` to push notifications to the client in real time, enabling toasts triggered from server-side events (e.g. a background process completing) to appear without a page reload.

Setup: enable the module (which requires `pusher_mini` and its Pusher credentials configured), and messages will be surfaced as toasts. This is a presentation/UX layer over the messenger with no admin routes of its own; configuration of the realtime transport lives in the Pusher/pusher_mini settings.
---
- Show Drupal status messages as toast popups.
- Present error/warning messages as toasts.
- Deliver notifications in real time via Pusher.
- Toast a message triggered from a background process.
- Notify users of events without a page reload.
- Layer toasts over the standard Messenger output.
- Surface success confirmations as transient toasts.
- Push a toast from a queue worker or cron job.
- Improve UX for long-running operations.
- Reuse pusher_mini's Pusher connection for messaging.
- Display multiple stacked toast notifications.
- Notify a specific user channel in real time.
- Replace the default message region with toasts.
- Provide unobtrusive, auto-dismissing feedback.
- Alert editors when an async task finishes.
- Integrate real-time notifications into an app-like UI.
- Keep users informed during AJAX-heavy workflows.
- Toast validation or save results after form submit.
- Signal system events (imports, syncs) live.
- Add modern notification UX on Drupal 10.1+.
