<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Send Multiple Emails adds a Webform handler that splits a comma-separated To list and sends each recipient their own individually-addressed email instead of one message addressed to all of them.

---

The module provides a single Webform email handler, "Send Multiple Emails" (`send_multiple_emails`), that extends Webform's core `EmailWebformHandler`. It behaves like the standard email handler when you configure it — same From, subject, body and element-mapping settings — but at send time it takes the resolved To value, splits it on commas, and calls the mail sender once per address so every recipient receives a separate message with only their own address in the To field. Because sending individually would duplicate the message to any CC/BCC recipients, the handler hides the CC and BCC configuration fields.

Two extra options are added to the handler form. A "Message prefix" section prepends a per-recipient salutation to the body: you supply prefix text containing a `[prefix_multiple_field]` placeholder plus a field/token that resolves to a colon-separated list of names aligned with the comma-separated addresses, and each recipient's message is prefixed with the name that lines up with their address. A "Send email to default" section lets you redirect every message from the handler to one fixed address, which is useful while testing that the generated emails are correct before pointing the form at real recipients.

The handler fires on `postSave` for the submission states you select (the same state checkbox set as the core email handler) and also on `postDelete` when the "deleted" state is chosen. It is unlimited-cardinality, so a single webform can carry several of these handlers.

---

- Send a webform notification to many recipients without any of them seeing the others' addresses.
- Replace the core email handler on a form that currently addresses a whole list in one To field.
- Notify a group of external parties (applicants, participants, subscribers) individually.
- Avoid BCC and the spam-filtering and reply quirks that come with it.
- Give each recipient a personalised salutation (e.g. "Dear [name],") aligned to their address.
- Drive the recipient list from a submission element or token that yields comma-separated addresses.
- Run an "email your representative" style form where a lookup returns a list of addresses.
- Add several Send Multiple Emails handlers to one webform for different recipient groups.
- Restrict sending to specific submission states (completed, updated, etc.) like the core handler.
- Also send a per-recipient notice when a submission is deleted.
- Route all handler emails to one test address while validating a new form.
- Send HTML or plain-text messages, inheriting the core handler's format toggle.
- Reuse the core handler's From, subject, body and reply-to configuration unchanged.
- Map the To value to a webform email element chosen at configuration time.
- Keep the recipient list private on forms handling personal data.
- Split a comma-separated address string into individual deliveries automatically.
- Preview the configured To/From addresses from the handler summary on the Emails/Handlers page.
- Personalise notifications where each recipient's message should differ only by their salutation.
- Audit an existing webform's handlers to confirm recipients are not exposed to each other.
- Estimate outgoing message volume, since one submission becomes one email per recipient.
