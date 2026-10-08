<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Mass Email sends one email to every address a chosen webform's submissions collected, queued and delivered on cron.

---

You already have the addresses — people typed them into a webform — and the job is to reach all of them: an event was cancelled and the registrants need telling, a form gathered expressions of interest and the follow-up must go out, a survey's respondents are owed the results, joining instructions changed. The module adds a **Mass Email** sub-tab under a webform's **Results**. You pick which of the form's email elements supplies the recipient address (it lists every `email`, `webform_email_confirm` and `webform_email_multiple` element on that form), type a subject and a body, and press **Send emails**. It reads the stored value of that element across all submissions, de-duplicates the addresses, and drops one queue item per unique recipient into Drupal's `webform_mass_email` queue; the message *"N items queued for sending"* tells you the recipient count **after** queueing. Nothing is sent in that request — a cron worker drains the queue, spending a configurable number of seconds per run (default 15, capped at PHP's `max_execution_time`), so a large list goes out over several cron runs rather than timing out. Each recipient gets an **individual** email (their address is the sole `To:` — the module never puts the list in `To`/`CC`, so it does not leak addresses between recipients), sent from the site's configured email address. The body supports **`[webform_submission:*]` tokens**, replaced per recipient with *that person's own* submission data (unmatched tokens are cleared), so a mail-merge greeting stays scoped to each recipient. Two global options exist at `admin/structure/webform/config/mass-email`: **Allow sending as HTML** (turns the body field into a rich-text editor and adds an HTML content-type header — you must separately install a module that actually renders HTML mail) and **Log emails** (writes one dblog entry per send). Two cautions the module does not enforce for you: **consent** — submitting a form is not agreement to receive further mail, so anything beyond the direct follow-up a submitter would expect needs its own lawful basis — and **deliverability** — hundreds of messages through default PHP `mail()` will bounce or be marked spam, so route them through a real MTA/relay. There is no built-in test send and no preview of the recipient list before you commit, so verify on a low-volume form first.

---

- Tell everyone who registered that an event is cancelled or rescheduled.
- Follow up with all applicants after an application window closes.
- Send survey results back to the people who responded.
- Email updated joining instructions or a venue change to registrants.
- Send a reminder before a deadline to everyone who submitted.
- Contact all expression-of-interest respondents with the next step.
- Notify entrants of a competition or draw result.
- Send a correction or erratum to everyone who received the original.
- Email a workshop's or webinar's sign-ups a calendar link.
- Thank all participants after an event.
- Reach everyone on a waiting list when a place opens.
- Follow up a public consultation's respondents.
- Send a personalised greeting using `[webform_submission:*]` tokens per recipient.
- Broadcast a service-status or maintenance notice to a form's subscribers.
- Send HTML-formatted newsletters (with a compatible HTML-mail module installed).
- Deliver a one-off announcement to a "keep me informed" sign-up form's addresses.
- Re-invite no-shows collected by a booking form.
- Push a large send out gradually over successive cron runs instead of one request.
- Restrict who can broadcast by granting the dedicated "Send Webform Mass Email" permission.
- De-duplicate a recipient list automatically before sending (repeated addresses are collapsed).
- Split a `webform_email_multiple` field's comma-separated addresses into individual recipients.
