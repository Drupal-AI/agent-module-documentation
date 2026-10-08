<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comment Notify emails commenters (including anonymous visitors) and content authors when new comments are posted, adding an opt-in checkbox to the comment form and a preference to user profiles.

---

Comment Notify hooks the core comment form (`hook_form_comment_form_alter`) to add a "Notify me when new comments are posted" checkbox for users with the `subscribe to comments` permission, on comment fields whose `entity--bundle--field` identifier is listed in `comment_notify.settings:bundle_types`. Two subscription modes are offered via `available_alerts`: all comments (`COMMENT_NOTIFY_ENTITY` = 1) and replies to my comment (`COMMENT_NOTIFY_COMMENT` = 2). When a comment is published the module (via `hook_comment_*` and `hook_mail`) emails each subscribed commenter and, if enabled, the author of the commented entity, using token-based subject/body templates in `mail_templates` (separate templates for `watcher` recipients and `entity_author`, per entity type such as `node`/`taxonomy_term`). Subscriptions are stored in a dedicated `comment_notify` database table (with an unsubscribe hash), and per-user default preferences live in the `user.data` store via the `comment_notify.user_settings` service (`UserNotificationSettings`). The user account form gains default-subscription checkboxes, and each notification email carries an unsubscribe link (routes `comment_notify.disable`/`comment_notify.unsubscribe`). Global defaults (`enable_default.watcher`, `enable_default.entity_author`) are set on the settings form at `/admin/config/people/comment_notify`.

---

- Email a visitor when someone replies to the comment they left on an article.
- Let anonymous commenters subscribe to follow-up notifications using their email address.
- Notify the author of a node whenever a new comment is posted on it.
- Offer "all comments" vs "only replies to mine" subscription choices on the comment form.
- Enable comment notifications only on specific content types (e.g. articles, not pages).
- Give logged-in users a default "always subscribe" preference on their account page.
- Send templated notification emails with tokens like `[node:title]` and `[comment:body]`.
- Provide a one-click unsubscribe link in every notification email.
- Let a user disable a specific comment subscription via a hashed disable URL.
- Customise the email subject/body for node comment notifications separately from taxonomy term comments.
- Set a site-wide default subscription mode for new commenters.
- Automatically subscribe content authors to comments on their own content by default.
- Restrict who can subscribe using the `subscribe to comments` permission.
- Let site admins configure everything from a single settings page (`administer comment notify`).
- Migrate legacy Drupal 7 comment_notify subscriptions (ships a migrate_drupal state).
- Keep a re-usable subscription record per comment (including the notifier's email and status).
- Encourage return visits by pulling commenters back when discussion continues.
- Send different templates to the "watcher" (commenter) and to the "entity author".
- Support comment notifications on any entity type that has a comment field, not just nodes.
- Turn off notifications globally for a bundle by removing it from `bundle_types`.
- Read a user's stored notification defaults programmatically via the `comment_notify.user_settings` service.
- Clean up a user's subscription preferences automatically when the account is cancelled/deleted.
- Prompt anonymous subscribers to register so they can auto-follow all future threads.
- Present only the subscription modes you want by toggling `available_alerts`.
- Add follow-up email capability to a discussion/forum-style site without custom code.
