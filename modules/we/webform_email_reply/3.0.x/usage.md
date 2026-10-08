<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Email Reply is a webform helper module that allows users to send an email reply to submissions.

---

Webform Email Reply lets authorized users send an email reply to a webform submission — so, from a
submission (e.g. a contact/support request), a staff member can compose and send a reply email to the
submitter directly from Drupal. It depends on the Webform module, provides its own permissions.

Use it to reply to webform submissions by email. It is a webform/messaging feature. Security-relevant points:
sending replies is gated by its permission (restrict who can reply); the reply email addresses the submitter
(so it uses the submission's email — be mindful of exposing/using submission PII), and the reply body is
composed by staff (avoid injecting untrusted content into outbound email). It has no access-control role
beyond its permission. Configure the reply behaviour.

---

- Reply to webform submissions by email.
- Compose a reply to the submitter.
- Reply from within Drupal.
- Depend on the Webform module.
- Provide its own permissions.
- Handle contact/support replies.
- Restrict who can reply (permission).
- Use the submission's email (mind PII).
- Avoid injecting untrusted content into email.
- Have no access-control role beyond permission.
- Configure the reply behaviour.
- Handle submission replies.
- Send reply emails.
- Configure replies.
- Reply to submissions.
- Handle the replies.
- Compose replies.
- Configure the feature.
- Restrict replying.
- Email submitters.
