<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow Notifications sends configurable email messages when a Workflow module state transition occurs, with token-templated subject and body, per-transition recipient rules, and cron-queued delivery for scheduled or time-based triggers.

---

Editorial workflow only works if the next person knows it is their turn. The Workflow contrib module models the states and transitions; this module attaches notifications to them. Each notification is a `workflow_notify` configuration entity, managed per workflow type at `/admin/config/workflow/workflow/{workflow_type}/notifications`, and describes three things: which transition it fires on (a from-state, a to-state, or "any" of either), when it fires, and what is sent (subject plus a rich-text body, both token-aware). Recipients are assembled from an explicit list of email addresses, the members of chosen roles, and optionally the content author, with an option to restrict to users who actually participated in the entity's transitions.

Three trigger modes cover the common cases. "On state change" sends immediately when the transition is saved, via `hook_entity_update`. "Some days before a scheduled state change" and "No state change for some days" are time-based: `hook_cron` queues them once a day onto the `workflow_notifications.send` queue, and the `ScheduleMailQueue` queue worker delivers them on later cron runs. Queued delivery for the time-based modes means the transition save itself is never tied to mail-server availability.

Mail is sent through Drupal's core mail manager, and `hook_mail()` marks the body as HTML, so the rich-text message renders as formatted email. Tokens in the subject, body, and recipient field are replaced against the changed entity and its transition (for example the node and the workflow transition), and the module adds a `workflow_state` token type of its own. The `workflow_sms_notify` submodule reuses the same trigger/recipient model to deliver SMS instead, through the core SMS Framework.

---

- Email a reviewer when content enters a review state.
- Notify an author when their content is published.
- Tell an editor when something is sent back for changes.
- Notify every member of a role on a specific transition.
- Send to an explicit list of email addresses, one per line.
- Also notify the content author (via the author "role") when they own the entity.
- Restrict a notification to users who actually participated in the entity's transitions.
- Fire immediately on a state change, or on a schedule.
- Warn assignees some days before a scheduled transition is due.
- Chase entities that have sat in a state with no change for N days.
- Template the subject and body with entity and transition tokens.
- Use the `workflow_state` token type to include the state id, label, or workflow id.
- Send formatted HTML email using a text-format body.
- Configure completely different notifications per workflow type.
- Queue time-based notifications for cron delivery instead of inline sending.
- Export notification rules as configuration with the rest of the site.
- Review, from the collection list, which transitions currently notify someone.
- Retire or delete a notification when a workflow changes.
- Add a notification without writing a custom hook or event subscriber.
- Layer SMS onto the same transitions with the `workflow_sms_notify` submodule.
