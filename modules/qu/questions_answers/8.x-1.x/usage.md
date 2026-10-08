<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Questions and Answers

Provides a `questions_answers` field type that attaches a Q&A thread to any entity. Question and Answer are content entities; a field formatter renders the thread and the ask/answer/report/subscribe/helpful forms according to the current user's permissions. New questions/answers can be auto-approved or held for moderation, with a moderation queue and email notifications.

---

# Installing & configuring

- Enable the module (depends on `user`) and configure global settings at `/admin/config/content/questions-answers` (permission `administer site configuration`).
- Add a `questions_answers` field to an entity bundle; set per-formatter options (auto-approve, 'was this helpful', date format, notification emails).
- Admin/moderation at `/admin/content/questions-answers` and `/admin/content/questions-answers/moderation` (permission `administer questions and answers`).
- Permissions: ask / answer / report / subscribe; unsubscribe route has custom access.

---

- Question/Answer are content entities; the formatter builds the thread from `viewElements()`.
- Entity-query lookups in the formatter use `->accessCheck()` and per-item `checkViewable()` gating.
- Question titles/answers are rendered through `t()` placeholders (`@title`) and Twig templates (auto-escaped).
- Forms are only built when the current user holds the matching permission (ask/answer/report/subscribe/helpful).
- Answers can be posted only when the question is published and the user has `answer questions and answers`.
- A moderation queue and `ModerationAlerts` block surface pending items to `administer questions and answers`.
- Auto-approve is per-formatter; admins' posts are auto-approved regardless.
- Email notifications of new questions go to a configured address list (`hook_mail` / `notify_subscriber`).
- Subscribe/unsubscribe forms let users follow a question; unsubscribe route uses a custom access check.
- Helpful voting is available to logged-in users when enabled.
- Report forms let users flag questions/answers; report counts are shown to admins.
- The admin `no_access_message` and `terms_and_conditions` link are admin config (rendered raw / via `Url::fromUserInput`).
- Views field plugins expose answer list, author, helpful votes, reported and subscribed columns.
- Roles `qa_staff_member` / `qa_top_contributor` are shipped and badged on answers.
- Permissions: administer / ask / answer / report / subscribe questions and answers.
- User-submitted content is escaped on output; no obvious stored-XSS or access-bypass was found.
