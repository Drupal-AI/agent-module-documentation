<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workbench Email sends templated notification emails when a content-moderation state transition occurs — ping reviewers when something moves to Needs Review, tell the author when their content is Published or sent back to Draft.

---

An editorial workflow only works if the right people know when the ball is in their court. Workbench Email attaches reusable **Email Template** config entities to specific workflow transitions: when a moderated entity changes state, every template registered for that workflow+transition (and, optionally, limited to matching bundles) fires. Each template defines a subject, a body (a filtered text-format field), an optional Reply-To, and a plain-text or HTML format. Subject, body and Reply-To all support tokens (e.g. `[node:title]`, `[node:author:mail]`) resolved against the transitioned entity. Recipients are computed by pluggable **recipient type** plugins — author, last revision author, roles, roles that also have update access, users referenced in an entity-reference field, any email field on the entity, or a fixed comma-separated address list. On a moderated entity save the module queues one `QueuedEmail` per resolved recipient into a per-entity-type queue and flushes it in the same request, so mails go out immediately (a cron queue worker is the fallback). Sending HTML requires a third-party mailer (Symfony Mailer, Swift Mailer, Mime Mail); plain-text bodies are converted with core's html-to-text helper. It depends on core Content Moderation and Filter, and gates template management behind the `administer workbench_email templates` permission.

---

- Email reviewers when content moves to Needs Review.
- Notify an author when their content is published.
- Notify an author when content is sent back to Draft/rejected.
- Attach an email template to one or more workflow transitions.
- Send different notifications per workflow.
- Limit a template to specific entity bundles.
- Send to all users holding a selected role.
- Send only to role-holders who also have update access to the item.
- Send to the entity author/owner.
- Send to the author of the previous revision.
- Send to users referenced in an entity-reference field.
- Send to the address stored in an email field on the entity.
- Send to a fixed, comma-separated list of addresses.
- Use tokens in the subject, body and Reply-To.
- Send HTML email (with a third-party mailer) or plain text.
- Set a Reply-To derived from the content author.
- Notify across any moderated entity type, not just nodes.
- Keep an editorial workflow moving without manual chasing.
- Avoid silent moderation states nobody is watching.
- Configure recipients precisely to prevent inbox noise.
- Send an approval-request email on submit-for-review.
- Announce a state change to a stakeholder group.
- Drive editorial handoffs between authors and editors.
- Alert a legal/compliance address on publish via a fixed recipient.
- Extend recipient resolution with a custom recipient-type plugin.
