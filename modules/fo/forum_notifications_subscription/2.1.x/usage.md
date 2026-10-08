<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forum Notifications Subscription adds per-user email subscriptions to core Forum, so people can follow a forum or a topic and be emailed when new topics or replies are posted.

---

Install with `composer require drupal/forum_notifications_subscription` and enable it (it depends on core **Forum**). Configure the button labels and email templates at **Administration → Configuration → System → Forum Notifications Subscription** (`/admin/config/system/forum_notifications_subscription`): set the subscribe/unsubscribe labels for forums and topics, the **Single** and **Daily Digest** subject/body templates for new topics and new comments, the daily-digest subject and header, and the default frequency for new subscriptions. Message bodies support module-specific replacement tokens (`[fns_topic:*]`, `[fns_comment:*]`, `[fns_dd:*]`) shown by the token browser on the form. To make the subscribe link appear, enable the **"Subscription link"** display component on the forum topic (`node.forum`) and forum container (`taxonomy_term.forums`) view displays, or render `{{ content.forum_notifications_subscription }}` in a template. Visitors then click **Subscribe / Unsubscribe** on a forum or topic; each subscriber picks per-subscription frequency (single email per event, or a batched **Daily Digest** sent once a day in their timezone) and can adjust those frequencies from a **Forum subscriptions** fieldset on their own account edit page (`/user/{uid}/edit`). Turn on **"Send single emails when cron run"** to queue single emails for cron delivery on busy sites; daily digests are always queued and drained by cron, so keep cron running.

---

- Let users subscribe to a whole forum and get emailed about new topics.
- Let users subscribe to a single forum topic and get emailed about new replies.
- Add a one-click AJAX Subscribe / Unsubscribe link to forum and topic pages.
- Offer immediate "single" emails for each new topic or comment.
- Offer a batched daily-digest email that summarizes the day's activity.
- Send each digest at midnight in the recipient's own timezone.
- Send notifications in each recipient's preferred language.
- Customize the subscribe and unsubscribe button labels.
- Customize email subjects and bodies for topics and comments.
- Insert dynamic values with forum/comment/digest replacement tokens.
- Set a default notification frequency for new forum subscriptions.
- Set a default notification frequency for new topic subscriptions.
- Let each user tune their frequencies from their account edit page.
- Show users their subscriptions via the shipped "Your subscription settings" view.
- Queue single emails for cron delivery to speed up page saves on busy forums.
- Auto-subscribe a topic's author to their own topic and its replies.
- Remove a topic's subscriptions automatically when the topic is deleted.
- Clear a user's subscriptions automatically when the account is blocked.
- Translate email templates per language via config translation.
- Restrict who can configure the module to site administrators.
- Reuse the subscribe link field inside custom Twig templates.
