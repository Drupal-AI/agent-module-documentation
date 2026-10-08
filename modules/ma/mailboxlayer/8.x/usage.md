<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Validate Webform email fields via the mailboxlayer API.

---

Mailbox Layer Integration integrates the mailboxlayer email-verification service into Webform email fields — so an email entered in a webform is validated (format, MX, disposable-address, deliverability) against the mailboxlayer API before submission, reducing invalid/fake emails.

The mailboxlayer API key is admin-configured and should be stored securely (env-backed), never committed. Depends on `webform`; supports Drupal 8 through 11.

---

- Validate webform email fields.
- Use the mailboxlayer API.
- Check format/MX/deliverability.
- Detect disposable emails.
- Reduce invalid submissions.
- Store the API key securely.
- Depend on `webform`.
- Support Drupal 8 through 11.
- Configure per webform.
- Aid data quality.
- Handle email validation.
- Verify emails
- Support Drupal.
- Support Drupal.
- Support Drupal.
