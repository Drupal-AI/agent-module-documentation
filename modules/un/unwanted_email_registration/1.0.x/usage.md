<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unwanted Email Registration adds an extra check of email addresses at account creation to catch duplicates using dots or other spacers.

---

Unwanted Email Registration adds an extra registration-time check on email addresses — detecting
addresses that are effectively **duplicates via dots or other spacers** (the classic Gmail trick where
`user.name@gmail.com`, `u.sername@gmail.com` and `username@gmail.com` all deliver to the same inbox), so a
single person can't repeatedly register "different" accounts by inserting dots. It is configured at
`unwanted_email_registration.settings`, provides its own permissions, in the Other package.

Use it to reduce duplicate/abusive self-registrations. This is a **security/anti-abuse-positive** feature: it
closes a common signup-abuse loophole (dot-trick account farming, promo/quota abuse). Note it normalizes
email variants for the duplicate check — configure it to match your policy. It has no access-control role
beyond its permission. Configure the check.

---

- Detect email-spacer duplicate registrations.
- Catch the Gmail dot trick.
- Prevent dot-trick account farming.
- Normalize email variants for the check.
- Configure at the settings.
- Provide its own permissions.
- Reduce duplicate/abusive signups.
- Close a signup-abuse loophole.
- Prevent promo/quota abuse.
- Have no access-control role beyond permission.
- Configure to match your policy.
- Handle the email check.
- Block duplicate emails.
- Configure the check.
- Detect spacer tricks.
- Handle registration abuse.
- Configure normalization.
- Prevent abuse.
- Handle the registration check.
- Block dot-trick signups.
