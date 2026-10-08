<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform send draft link lets a webform's "Send Link to Draft" tab email a link that resumes a saved draft submission.

---

When a webform has "Allow users to send links to drafts by email" enabled (a third-party setting added to the webform submissions settings form) and Webform's secure update token is turned on, the module stores the current draft's token URL and offers a form (`WebformSendDraftLinkForm`) at routes like `/form/{webform}/send_draft_link`. The form collects recipient email(s), subject and message and sends the resume link via `simple_mail_send()`. The link itself is Webform core's `getTokenUrl('update')` — an unguessable, per-submission secure token — and the module's own validator refuses to enable the feature unless the `token_update` secure-token setting is on.

Security notes to weigh: the resume token is strong (Webform core secure token), so it is not a weak/guessable token. However the token URL is cached in `\Drupal::state()` keyed only by **webform id** (overwritten on every draft presave), and the send form's access check (`WebformSendDraftLinkForm::access`) only requires the third-party setting to be enabled plus an allowed route — no ownership/permission check. On a webform any user can reach, that means a user can email the **most recently saved draft's** resume link to an arbitrary address, disclosing/allowing takeover of another user's in-progress draft. Restrict the feature to webforms and roles where that is acceptable.
---
- Enable "send links to drafts by email" on a webform
- Add a "Send Link to Draft" tab to a webform
- Email a draft resume link to a recipient
- Send the link to several comma-separated emails
- Include a custom subject and message with the link
- Resume a partially completed submission from email
- Require Webform's secure update token before enabling
- Use simple_mail to deliver the message
- Let staff resend a submitter's draft link
- Combine with Webform draft (save & finish later) settings
- Show the token link on the send form for copy/paste
- Send links from the submission view/edit/notes tabs
- Warn when the draft has not been saved yet
- Warn when the submission is already completed
- Configure per-webform whether the feature is available
