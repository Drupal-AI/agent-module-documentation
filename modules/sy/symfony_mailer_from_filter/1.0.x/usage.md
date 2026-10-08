<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer From Filter enforces an allowlist of From addresses for outgoing email.

---

Symfony Mailer From Filter limits all outgoing email From addresses to an allowlist and moves unrecognized From addresses (e.g. to a fallback/reply-to) — so a site can guarantee mail is only sent from approved, SPF/DKIM-aligned addresses, improving deliverability and preventing spoofed sender addresses.

It's a Symfony Mailer email-hardening enhancement with no content or access role of its own. Depends on `symfony_mailer`; supports Drupal 10 and 11.

---

- Allowlist outgoing From addresses.
- Move unrecognized From addresses.
- Ensure approved senders only.
- Align with SPF/DKIM.
- Improve deliverability.
- Prevent spoofed senders.
- Build on Symfony Mailer.
- Depend on `symfony_mailer`.
- Support Drupal 10 and 11.
- Carry no content/access role.
- Configure the allowlist.
- Harden email sending.
- Fallback unrecognized From
- Enforce sender policy
- Support email security.
- Filter From addresses.
- Handle sender addresses.
- Restrict senders
