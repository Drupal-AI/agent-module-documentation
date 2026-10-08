<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate Form adds a coupled email / lead-capture form that grants a gated download on submission.

---

File Gate Form is an optional submodule of File Gate that adds a `form` gate method for coupled and hybrid sites
that want File Gate delivery without building their own front-end gate. It depends only on `file_gate`. Drupal
renders a lightweight email / lead-capture form at `/file-gate/form/{file}`; a valid submission records a
per-session grant (private tempstore, TTL-limited) and redirects the visitor to the download, which the `form`
gate method checks. Submissions are spam-guarded (an off-screen honeypot field plus a per-IP rate limit) and the
email is format-validated; an optional required consent checkbox and intro text are configurable per field. File
Gate stores no PII itself — each valid submission dispatches a `LeadCapturedEvent` so the site can persist the
lead into Contact, Webform, or a CRM and keep retention and consent decisions with the site. Enable with
`drush en file_gate_form`.

---

- Gate a downloadable file behind a native Drupal email / lead-capture form (`form` gate method).
- Let coupled or hybrid sites use File Gate delivery without building a headless gate.
- Render the capture form at `/file-gate/form/{file}` (404s for a file not gated with the `form` method).
- Grant a per-session, TTL-limited download after a valid submission (default 1 hour).
- Redirect the visitor straight to the gated download on success.
- Require an email address and validate its format.
- Add an optional required consent checkbox with custom label text.
- Show optional intro text above the form.
- Block bots with an off-screen honeypot field (rejected without revealing why).
- Rate-limit submissions per IP (10 per hour).
- Keep PII out of File Gate — dispatch a `LeadCapturedEvent(file, email, consent)` for the site to persist.
- Feed captured leads into Contact, Webform, a CRM, or any event subscriber.
- Combine the lead gate with File Gate's deny-by-default `/system/files` protection.
- Set the access window (TTL) after submission per field.
- Layer the form gate alongside signed-URL, OTP, commerce, or assurance gates on other fields.
