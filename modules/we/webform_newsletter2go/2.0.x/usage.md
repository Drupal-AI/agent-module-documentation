<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Newsletter2Go provides Newsletter2Go integration for Webform.

---

Webform Newsletter2Go integrates Drupal Webform with Newsletter2Go (now Brevo) — so Webform submissions
can subscribe contacts to Newsletter2Go mailing lists (a Webform handler that pushes submission data to the
service). It is configured at `webform_newsletter2go.settings`, provides its own permissions, in the Webform
package.

Use it to feed Webform sign-ups into Newsletter2Go. Security note: it authenticates to the Newsletter2Go/Brevo
API with credentials — **store those as secrets** (not in exported config), operate over HTTPS, and be mindful
that submission data (email/PII) is sent to the external service (obtain consent for marketing, handle per
privacy). It has no access-control role beyond its permission. Configure the Newsletter2Go connection.

---

- Integrate Webform with Newsletter2Go.
- Subscribe contacts from Webform submissions.
- Push submission data to Newsletter2Go/Brevo.
- Configure at webform_newsletter2go.settings.
- Provide its own permissions.
- Store the Newsletter2Go credentials as secrets.
- Operate over HTTPS.
- Send email/PII to the service (obtain consent).
- Handle data per privacy.
- Have no access-control role beyond permission.
- Configure the connection.
- Handle newsletter sign-ups.
- Feed sign-ups to the service.
- Configure credentials.
- Handle the API securely.
- Subscribe via Webform.
- Integrate the newsletter.
- Configure Newsletter2Go.
- Handle marketing sign-ups.
- Push to Newsletter2Go.
