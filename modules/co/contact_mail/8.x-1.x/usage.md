<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Mail alters the emails core's Contact forms send: common extra recipients, an optional formatted HTML submission, and an HTML Content-Type.

---

Contact Mail hooks `hook_mail_alter()` and acts only on the core Contact module's `contact_page_mail`
and `contact_page_copy` messages. From a single settings form (`contact_mail.settings` at
`/admin/config/system/contact-mail`, permission "administer contact forms") you can: add a common list
of extra recipients that receive every contact form's mail, re-render the submission as a formatted
table with an admin-defined header block, and send the mail as `text/html` instead of plain text. It is
a small utility in the Mail package with no dependencies, no permissions of its own, and no Drush
commands.

Note the info.yml ships a stale `configure: synmail.config` pointer to a route that no longer exists, so
`drush en` prints a "Route synmail.config does not exist" warning and the Extend page's Configure link is
broken — the module still installs; reach the form from the Configuration › System admin menu ("Contact
Mail Settings") or the path directly. Contact emails carry the submitter's message and often their email
address, so review the recipients you configure.

---

- Alter core Contact-form emails via hook_mail_alter().
- Act only on contact_page_mail and contact_page_copy messages.
- Add common extra recipients to every contact form.
- Append config addresses to the message's To.
- Re-render the submission as a formatted table.
- Prepend an admin-defined header block to the body.
- Send the mail as text/html instead of plain text.
- Set the Content-Type header to text/html.
- Configure at /admin/config/system/contact-mail.
- Require the "administer contact forms" permission.
- Reach the form via Configuration › System.
- Work around the broken synmail.config configure link.
- Build the submission from the contact_message entity fields.
- Respect the contact form's view display and field weights.
- Link file fields to their absolute file URL.
- Map list/allowed-value fields to their labels.
- Provide the contact_mail theme hook and submission template.
- Expose contact_mail_alter_message and _emails alter hooks.
- Sit in the Mail package with no dependencies.
- Review recipients since emails carry submitter data.
