<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow SMS Notification adds SMS delivery to Workflow Notifications, sending a text through the core SMS Framework when a configured Workflow state transition occurs.

---

Email is the right default for editorial notifications and the wrong one for anything urgent. An approval blocking a publication deadline, an escalation after an item has sat in review too long, an incident workflow reaching a state that needs a person now — these want a channel that reaches someone away from their desk. This submodule adds that. It reuses the parent module's `workflow_notify` trigger and recipient model but stores phone numbers instead of email addresses (a `workflow_sms_notify` config entity with a `phone_num` field), and it manages rules on a sibling **SMS** tab at `/admin/config/workflow/workflow/{workflow_type}/sms-notifications`.

Delivery goes through the SMS Framework (`sms`): the module builds an outgoing `SmsMessage` from the rule's message body and queues it on the framework's default gateway, so the actual carrier is whatever the site already configured under SMS Framework rather than anything this module owns. Recipients come from the numbers typed into the rule plus the **verified** phone numbers of members of the chosen roles (unverified numbers are skipped). Like the parent, immediate rules fire on `hook_entity_update` and time-based rules are queued on cron.

Two things are worth deciding deliberately, and they are the same two every time SMS is attached to a workflow. **Cost:** messages are billed individually, so a rule on a frequent transition becomes a recurring bill nobody reviews — reserve SMS for escalations and approvals, not routine state changes. **Timing:** a text arrives immediately, including at 3am, so confirm the recipient list and that the transition is genuinely urgent.

---

- Text an approver when content needs approval.
- Escalate an overdue review by SMS.
- Notify an on-call person of an urgent state change.
- Reach an approver who is away from email.
- Add SMS alongside email on the same transition.
- Send through the site's already-configured SMS Framework gateway.
- Target the verified phone numbers of members of a role.
- Send to an explicit list of phone numbers, one per line.
- Configure SMS notification rules per workflow type.
- Limit SMS to high-priority transitions only.
- Fire an SMS immediately on a state change.
- Chase a scheduled transition with a text some days before it is due.
- Alert when an entity has had no state change for N days.
- Template the SMS body with entity and transition tokens.
- Restrict SMS to users who participated in the entity's transitions.
- Unblock a publication deadline waiting on approval.
- Keep SMS and email notification config side by side on one workflow.
- Review the cost implications of an SMS rule before enabling it.
- Add SMS notifications without writing custom code.
