<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push Framework is an orchestration layer that collects content needing to be pushed and delivers it to recipients across pluggable notification channels — email, SMS, Slack, push, and so on — using a durable queue.

---

The framework itself sends nothing: it defines two plugin types and coordinates them. **Source** plugins report which objects need pushing and to whom; **channel** plugins (each a separate contrib module such as Email, Twilio, Slack, OneSignal, Mattermost or Alerta) render and deliver the message. On each cron run — or via the drush commands **`pf:sources:collect`** and **`pf:queue:process`** — the central service walks every source, skips recipients who opted out, deduplicates, and enqueues one job per (object, recipient) onto an **Advanced Queue** (`push_framework`, database backend). Processing each job asks every applicable, active channel, in a configurable order, to build content from admin-set subject/body **token patterns** (rendered through a chosen entity display mode) and send it; on the first success the remaining channels are skipped so a user is not notified twice, and transient failures are retried with a delay. Install with `composer require drupal/push_framework` (pulls in `drupal/advancedqueue`), enable it, then configure templates, display modes and channel order at **`/admin/config/system/push_framework`** (permission `administer site configuration`). Add one or more channel modules for actual delivery, and pair it with **DANSE** (or the `eca_push_framework` submodule) as a source. Because delivery runs on the queue, plan a real queue runner — cron alone means notifications go out only as fast as cron fires. Keep provider credentials in environment-backed Key entities, and model consent explicitly: users opt out per account, and admins can block or allow a user with the bundled bulk actions.

---

- Send notifications to users across several channels at once.
- Add a delivery channel (email, SMS, Slack, push) without rebuilding the plumbing.
- Queue outgoing messages durably instead of sending inline.
- Retry a failed notification automatically with a backoff delay.
- Try channels in a set order and stop at the first successful delivery.
- Avoid spamming a user with the same notification on multiple channels.
- Feed content into the push queue from a custom source plugin.
- Use DANSE as the source of what gets pushed.
- Trigger a notification from an ECA model via the eca_push_framework submodule.
- Collect and process the queue on cron.
- Run collection and delivery manually with `drush pf:sources:collect` and `drush pf:queue:process`.
- Format notifications with token-based subject and body patterns.
- Render the pushed object using a specific display mode.
- Send an ad-hoc notification to a user with the "Push a notification to a channel" action.
- Let users opt out of all push notifications per account.
- Block or allow notifications for users in bulk from the People admin.
- Suppress email to users who have blocked notifications.
- Migrate existing user notification-block preferences via the user-data destination.
- Report delivery outcomes back to the originating source.
- Consolidate scattered one-off notification code into one orchestrated pipeline.
