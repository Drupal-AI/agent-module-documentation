<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anonymous author provides a field type that lets anonymous visitors record a name and email against entities they create, with optional email notifications on updates and comments.

---

The module adds an `anonymous_author` **field type** with three stored columns — `name`, `email` and `notify` (a boolean) — plus a matching widget and formatter. The widget (`AnonymousAuthorWidget::formElement`) only renders the name/email inputs when it is safe to do so: on a *new* entity it shows the fields only to anonymous users, and on an *existing* entity only to users holding the `edit anonymous author fields` permission. The stored "author" is free-text name/email metadata — it is **not** a Drupal user account or `uid`, so it does not reassign real user ownership or impersonate an account.

The module does not grant any content-creation permission itself; whether an anonymous visitor can create the host entity is still governed entirely by core entity/access permissions (e.g. node/comment create). When the entity is later updated, or a comment is added to it, `hook_entity_update`/`hook_entity_insert` send a notification email to the stored address if the visitor ticked "notify" — the recipient is the user-supplied email, and modules/themes may alter the message via the `anonymous_author_notification` alter hooks. Operational note: because the notify email goes to an unvalidated visitor-supplied address, treat it like any user-submitted content.

---
- Add the `anonymous_author` field to a content type or comment type
- Let anonymous visitors leave their name/email when creating content
- Collect an optional notify flag for update/comment notifications
- Show the author name/email via the anonymous author formatter
- Configure name/email placeholder text on the widget
- Grant `edit anonymous author fields` to moderators who edit submissions
- Keep the author fields hidden from non-anonymous users on new entities
- Notify anonymous authors by email when their content is updated
- Notify anonymous authors when a comment is added to their content
- Suppress self-notification when the author comments on their own post
- Alter notification subject/body via `hook_anonymous_author_notification_alter`
- Alter per-type messages via `hook_anonymous_author_notification_update/comment_alter`
- Store guest contributor details without creating user accounts
- Combine with core anonymous create permissions for guest submissions
- Display attributed authorship on user-generated content
