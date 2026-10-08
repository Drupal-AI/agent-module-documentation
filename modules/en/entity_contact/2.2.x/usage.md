<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Contact is a stripped-down, fully fieldable reimplementation of Drupal core's Contact module: each contact form is a config entity and each submission is a `entity_contact_message` content entity you can add fields to.

---

The problem it solves is that core contact forms are not real fieldable entities and their submissions are not stored. Entity Contact makes both the form (`entity_contact_form`) and the message (`entity_contact_message`) first-class entities, so you can attach fields, list/store/expire submissions, and process them through **submission handler** plugins (an e-mail handler ships in the `entity_contact_email` submodule). The public submission page is gated by the dedicated `access entity contact form` permission — not `access content`. On insert (`entity_contact_entity_insert`) every message is passed to the submission-handler manager; if the form's *store submission* flag is off the message is deleted after handling. `entity_contact_cron` purges expired messages (`remove_stored_submissions_after`). A flood limit/interval (Settings form) throttles submitters and an optional setting stores the submitter IP. Each new message also records UTM/GCLID marketing parameters and a submission URL captured from the request or referer.

The e-mail submodule (`Service\Mailer`) sends admin-configured mails: recipients are static addresses configured on an `entity_contact_email` config entity plus, optionally, the value of an explicitly chosen message field (limited to `email`/`list_string` field types and validated with `EmailValidator`, and constrained to allowed values for list fields). Subject/body are admin templates run through Token and the core mail manager, so recipients are not arbitrary submitter input unless an admin deliberately maps a recipient field. File fields on the form can be attached to the mail. Typical setup: create a contact form, add fields, grant `access entity contact form`, then add an e-mail on the form and set the recipient(s). 2.2.x requires `phpoffice/phpspreadsheet` for the XLSX export submodule.
---
- Create a contact form as a fieldable config entity at /admin/content/entity-contact
- Add custom fields (name, e-mail, message, file, select lists) to a contact form
- Store submissions as `entity_contact_message` content entities
- Toggle whether submissions are persisted or discarded after handling
- List and view submissions per form for authorized roles
- Bulk delete all submissions for a form via the confirm form
- Auto-expire and cron-purge old submissions with a `strtotime()` interval
- Grant only `access entity contact form` to expose the public form
- Configure a flood limit and interval to throttle submissions
- Optionally store the submitter IP address (GDPR-aware toggle)
- Capture UTM/GCLID marketing parameters and submission URL per message
- Preview a submission before sending when a preview display is enabled
- Route submissions through custom submission-handler plugins
- Send e-mail on submission via the entity_contact_email submodule
- Route mail to static recipient addresses configured per form
- Route mail to the value of a chosen email/list message field (e.g. reply-to a user)
- Attach uploaded file fields to the submission e-mail
- Use Token replacement in mail subject/body (form label, message fields, list-fields)
- Render all submitted fields into a mail with the `list-fields` token
- Export submissions with pluggable layouts and formats (CSV, XLSX)
- Index submissions in Search API via entity_contact_search_api
- Embed a contact form on the `/contact-form/{form}` route via entity_contact_route
- Provide an example submission handler as a coding starting point
- Restrict submission viewing with `view entity contact form submissions`
- Restrict form administration with `administer entity contact forms`
- Add contact-form local task tabs per registered submission handler
- Theme the form title/description via the preprocess hook
