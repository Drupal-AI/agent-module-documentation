Sends configurable emails when a content-moderation-managed entity moves between workflow states (e.g. Draft → Needs Review → Published), targeting the content author, whole roles, ad-hoc addresses, or user-reference fields on the entity.

---

Content Moderation Notifications extends core's Content Moderation / Workflows with email alerts tied to moderation-state transitions. You create `content_moderation_notification` config entities at Administration → Configuration → Workflow → Content Moderation Notifications (`/admin/config/workflow/notifications`); each one is scoped to a single workflow and a chosen set of that workflow's transitions. When a moderated entity is saved and the detected transition matches an enabled notification, the module gathers recipients — the entity author, every active user in selected roles (each checked for `view` access to the entity), a list of ad-hoc addresses, and emails pulled from configured entity-reference user fields — and sends one message. All recipients are placed on the `Bcc` header; the visible `To` is the site mail address unless "disable site mail" is set. Subject and body support both Drupal tokens and inline Twig, and the body is run through a selected text format's filters before sending. It adds three tokens (`workflow`, `from-state`, `to-state`) and invokes `hook_content_moderation_notification_mail_data_alter()` so other modules can adjust the recipient list and mail data. It depends on `content_moderation`, `text`, and `workflows`; `token` is an optional (dev/recommended) enhancement.

---

- Email the reviewer role whenever an author moves an article from Draft to Needs Review.
- Notify the content's author when their submission is published or rejected.
- Alert a legal/compliance role on transitions into a "Ready to publish" state.
- CC an external stakeholder mailbox (ad-hoc address) on every publish event.
- Send a copy to a per-node "content owner" entity-reference user field when state changes.
- Trigger different messages for different transitions within the same editorial workflow.
- Build subject lines dynamically with Twig, e.g. `{{ entity.bundle|title }} needs review`.
- Insert moderation context into emails using the `[content_moderation_notifications:from-state]` and `:to-state` tokens.
- Include the workflow label in a message via the `[content_moderation_notifications:workflow]` token.
- Notify all authenticated users of a site-wide announcement moving to Published.
- Keep recipients private from one another by relying on the forced `Bcc` delivery.
- Suppress the site-address recipient (leave only Bcc recipients) via the "disable site mail" flag.
- Route notifications only to users who actually have permission to view the entity.
- Send rich HTML emails by choosing a Full HTML text format for the message body.
- Pull manager/approver emails from a referenced department entity using Twig field traversal.
- Restrict who can create and edit notifications with the "administer content moderation notifications" permission.
- Enable or disable individual notifications without deleting them, from the collection list.
- Add extra recipients programmatically with `hook_content_moderation_notification_mail_data_alter()`.
- Integrate with the Twig Tweak module to call `drupal_token()` inside notification templates.
- Give editors a heads-up email that new content is waiting in their moderation queue.
- Notify a translations team when content enters a review state in a specific workflow.
- Drive approval chains by emailing the next approver group at each successive transition.
- Send author-only confirmations without exposing internal reviewer addresses.
- Reuse one notification across several transitions that should all alert the same group.
- Combine role recipients and ad-hoc addresses in a single notification.
- Localize sending by using the current user's preferred language code for the mail.
