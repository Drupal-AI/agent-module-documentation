<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookiehub integrates the third-party CookieHub cookie-consent/compliance service by injecting its loader script into every page (subject to path rules) and adds a "cookie declaration" field type, widget and formatter.
---
The module solves GDPR/ePrivacy cookie-consent needs by wiring a Drupal site to a CookieHub account. On the settings form (`/admin/config/services/cookiehub`, permission `administer cookiehub configuration`) an admin enters their 8-digit CookieHub code (`id`), toggles the banner on (`enable`), chooses development mode (loads from `dash.cookiehub.com/dev/<id>.js` instead of `cookiehub.net/c2/<id>.js`), toggles automatic cookie blocking, and lists paths where the banner should be suppressed. `hook_page_attachments()` then appends the CookieHub `<script>` to `html_head` (weight -1000/-999) on non-excluded paths; the automatic-blocking variant loads the script via a `src` attribute and calls `window.cookiehub.load()`, while the default variant injects an inline loader snippet. A field type (`CookieDeclaration`), widget and formatter let editors place a cookie-declaration block on a page.

Operational and security notes: the embedded script is a first-party-configured, well-known third-party asset (cookiehub.net / dash.cookiehub.com) — the point of the module. The account `id` is admin-supplied and should be a plain 8-digit code. Path suppression uses the path matcher after resolving the alias. The typical setup task is: obtain the CookieHub code, enter it, enable the banner, and optionally exclude a few paths.
---
- Enter your 8-digit CookieHub account code to connect the site.
- Enable the CookieHub consent banner site-wide.
- Toggle development mode to load the dev build of the script.
- Enable automatic cookie blocking so scripts wait for consent.
- Use the default inline loader when automatic blocking is off.
- Exclude specific paths (one per line, `*` wildcard) from the banner.
- Keep the banner off certain landing pages via the disable list.
- Load the script early via html_head weighting (-1000/-999).
- Add a cookie-declaration field to a content type.
- Configure the cookie-declaration widget on a form display.
- Render the cookie declaration with its field formatter.
- Provide a dedicated "cookie policy" page using the declaration field.
- Switch between production and dev CookieHub endpoints without code.
- Disable the integration by unchecking "enable".
- Grant "administer cookiehub configuration" to a compliance admin role.
- Update the CookieHub code when moving to a new account.
- Combine with a privacy policy page for full GDPR coverage.
- Suppress the banner on API/utility paths.
- Verify the script loads by inspecting the page head.
- Style the consent UI via the module's cookiehub CSS library.
