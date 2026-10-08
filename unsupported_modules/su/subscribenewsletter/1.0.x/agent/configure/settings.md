<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Subscribe Newsletter

Admin form `subscribenewsletter.admin_settings` → `/admin/config/newsletter/api` (perm `administer site configuration`). Config object `subscribenewsletter.subscribeendpoints`:
- `title`, `description` — shown in the block.
- `endpoint_url` — external newsletter API URL.
- `API_Key` — appended to the URL at submit time as `endpoint_url . '&' . API_Key` (travels in the request URL, not a header — use HTTPS).
- `fid_logo` — managed_file logo id (saved permanent).

## Submit behaviour (SubscribeNewsletterForm)
- Public form at `/subscribenewsletter` (perm `access content`, so anonymous-reachable; CSRF-protected as a FormBase).
- Validates the email via `email.validator`.
- POSTs `['json' => ['EMAIL' => <email>]]` to the composed URL via `\Drupal::httpClient()`.
- Logs the serialized response to the `NewsletterSignupForm` channel, shows a success message, redirects to `<front>`.
- No double-opt-in / confirmation token. Add CAPTCHA/honeypot to curb anonymous abuse.
