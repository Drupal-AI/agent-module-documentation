<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PhpMail Alter alters the Drupal mail function, letting you adjust mail headers/parameters through configuration.

---

PhpMail Alter alters Drupal's mail handling — letting administrators adjust aspects of outgoing mail
(headers, envelope/From parameters, and similar) through configuration rather than code. It is configured
at `phpmail_alter.settings` and is in the Mail package. Typical uses are setting a correct envelope-from,
adjusting headers for deliverability, or similar mail tweaks.

Use it to fix mail headers/parameters where the defaults don't suit your mail setup. It operates on
outbound email, so review the configured changes carefully: mis-set From/envelope headers can hurt
deliverability or, in the worst case, cause mail to appear to come from the wrong sender. It has no
content-access role. Configure the mail alterations to match your mail infrastructure.

---

- Alter Drupal mail headers/parameters.
- Set the envelope-from.
- Adjust headers for deliverability.
- Configure mail tweaks.
- Configure at phpmail_alter.settings.
- Operate on outbound email.
- Review configured mail changes.
- Avoid mis-set From headers.
- Not affect content access.
- Match your mail infrastructure.
- Fix mail parameters.
- Adjust mail handling.
- Set correct sender headers.
- Tweak outgoing mail.
- Improve deliverability.
- Configure the alterations.
- Handle mail via config.
- Adjust envelope headers.
- Modify mail behaviour.
- Configure mail headers.
