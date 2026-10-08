<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Bard Integration (google_bard) — agent index

**Sends prompts to the unofficial cookie-authenticated Google Bard endpoint from a Drupal form.**

- **Version:** 1.0.x  | **Core:** ^9 || ^10  | **Package:** Generative AI
- **Configure:** `/admin/config/system/google-bard-settings` (route `google_bard.settings`, perm `administer site configuration`) — stores two Google cookies (api_key_x = __Secure-1PSID, api_key_y). Query form `/google-bard` (perm `access content`).
- **Client:** `src/Form/Bard.php` uses raw cURL to `bard.google.com`, sending the cookies as credentials.

**Security review — see report.** Findings: (1) **Disabled TLS** — `CURLOPT_SSL_VERIFYHOST=FALSE` and `CURLOPT_SSL_VERIFYPEER=FALSE` on both requests (`Bard.php:113-114` and `:151-152`) while the requests carry the Google account session cookies (`__Secure-1PSID`) — a MITM can capture full Google-account credentials. (2) Cookies stored in plaintext config and injected via `$_ENV`. (3) The `/google-bard` form is available to `access content` (anonymous by default) and answers are stored in **shared** `\Drupal::state()` (one user's conversation is visible to all). Experimental/unofficial integration.
