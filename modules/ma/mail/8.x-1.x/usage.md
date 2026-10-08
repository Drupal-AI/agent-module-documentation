<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail provides a config entity for emails sent by the site.

---

Mail provides a configuration entity for site emails — letting you define/manage the emails the site
sends (subject, body, recipients) as configuration, so email content is manageable/exportable rather than
hardcoded. It ships a `mail_example` submodule, provides its own permissions, in the Mail package.

Use it to manage site email templates as config. It is an administration/messaging feature; the email
definitions are configuration and it has no access-control role beyond its permission (gating who edits the
emails). Note email bodies may include tokens/user data — ensure sensitive data isn't inadvertently emailed.
Configure the email entities.

---

- Manage site emails as config entities.
- Define subject/body/recipients.
- Make email content manageable/exportable.
- Ship an example submodule.
- Provide its own permissions.
- Avoid hardcoded emails.
- Gate who edits the emails.
- Ensure sensitive data isn't emailed.
- Have no access-control role beyond permission.
- Configure the email entities.
- Handle email templates.
- Manage emails.
- Configure emails.
- Handle site email.
- Define emails.
- Manage email config.
- Configure the emails.
- Handle email content.
- Restrict email editing.
- Manage email entities.
