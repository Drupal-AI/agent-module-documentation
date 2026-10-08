<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Entity Email allows sending a node in a specific display mode via a Webform email handler.

---

Webform Entity Email adds a **Webform email handler that sends a rendered entity** — a node in a chosen
display mode — as (part of) the email, so a webform submission can trigger an email containing the rendered
content of a specific node/entity. It ships a `scheduled` submodule (scheduled sending) and depends on the
Webform module, in the Webform node email package.

Use it to email rendered node content from webform submissions. It is a forms/email-integration feature.
Security/privacy notes: the email includes **rendered entity content**, so ensure the chosen display mode does
not expose fields the recipient shouldn't see, and (as with any submission-triggered email) validate
recipients to avoid the form becoming a mail relay. It has no access-control role. Configure the handler's
entity, display mode and recipients.

---

- Send a rendered entity via Webform email.
- Email a node in a chosen display mode.
- Trigger email from a submission.
- Ship a scheduled-sending submodule.
- Depend on the Webform module.
- Include rendered content in email.
- Ensure the display mode hides sensitive fields.
- Validate recipients (avoid mail relay).
- Have no access-control role.
- Configure the handler.
- Handle entity emails.
- Email nodes.
- Configure the display mode.
- Handle the handler.
- Send rendered content.
- Configure recipients.
- Handle webform email.
- Email content.
- Schedule sending.
- Provide entity email.
