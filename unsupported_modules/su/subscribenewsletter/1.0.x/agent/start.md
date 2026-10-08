<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscribe Newsletter (subscribenewsletter) — agent index
**A simple email-subscribe form/block that POSTs the entered address to an admin-configured external newsletter API.**

- **Version:** 1.0.x
- **Core:** ^9.3 || ^10 · **Package:** Subscribe Newsletter
- **Public form:** `subscribe_newsletter_form` → `/subscribenewsletter` (perm `access content` — effectively anonymous)
- **Admin form:** `subscribenewsletter.admin_settings` → `/admin/config/newsletter/api` (perm `administer site configuration`)
- **Block:** `SubscribeNewsletterBlock` (template `block--subscribenewsletter`)
- **Config:** `subscribenewsletter.subscribeendpoints` (endpoint_url, API_Key, title, description, fid_logo)

**Security:** The public subscribe route is gated only by `access content` (anonymous-reachable) and triggers an outbound API POST with an arbitrary email; it is a Drupal FormBase so CSRF-token protected. NOTE: no confirmation/double-opt-in token; the API key is stored in plain config and concatenated onto the endpoint URL (`endpoint_url . '&' . API_Key`, SubscribeNewsletterForm.php) so it rides in the request URL — use an HTTPS endpoint. Consider adding CAPTCHA/honeypot.

See [configure/settings.md](configure/settings.md)
