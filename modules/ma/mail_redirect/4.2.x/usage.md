<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Redirect redirects ALL system-generated email to a configured test mail domain or address, for testing on sites with real email addresses in the database.

---

Mail Redirect redirects **all** outbound system email to a configured test address or domain — for
testing email on non-production sites that contain real email addresses (a copied production database), so
that test sends don't reach real users. It is configured at `mail_redirect.admin_settings` and is in the
Mail package.

**Security/operational caveat — this is a testing tool that must never run on production.** Because it
intercepts and redirects *every* outbound email, enabling it on a live site would (1) stop all real emails
— password resets, order confirmations, notifications — from ever reaching users, and (2) send those
emails (which may contain personal data, reset links, order details) to the configured test address
instead, exposing that data to whoever controls it. Use it only on development/staging environments with a
copied database, and ensure it is disabled/absent on production. Treat its presence in a production
deployment as a misconfiguration to fix immediately.

---

- Redirect all outbound email to a test address.
- Test email on non-production sites.
- Avoid emailing real users in test.
- Configure at mail_redirect.admin_settings.
- Use with a copied production database.
- Never enable on production.
- Know it intercepts every email.
- Understand real emails won't reach users.
- Avoid exposing PII to a test address.
- Use on dev/staging only.
- Disable/remove on production.
- Treat production presence as a misconfiguration.
- Redirect to a test domain.
- Prevent test emails to real addresses.
- Handle reset/order emails safely in test.
- Configure the test recipient.
- Test mail functions safely.
- Scope to non-production.
- Protect user email data.
- Intercept system email in test.
