<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CookiePro by OneTrust injects the OneTrust/CookiePro cookie-consent banner and preference-center script into your site's HTML head, so you can meet GDPR/CCPA/ePrivacy cookie-consent requirements. It is a thin integration: you paste the script tag OneTrust gives you into one settings field, and the module renders it on every page.

---

CookiePro provides a single settings form at `/admin/config/development/cookiepro` (route `cookiepro.admin.header`) with one textarea, "Scripts", stored in the config object `cookiepro.header.settings` under the key `scripts`. Whatever you paste there — typically the OneTrust "Main Cookies Script Tag" (an autoblocking `<script src="...otSDKStub.js" data-domain-script="...">`), plus optional Cookie Settings / Cookie List snippets — is parsed by `hook_page_attachments_alter()` and emitted into the page `<head>` on every request. The parser splits the raw input on `</script>`/`</noscript>`, strips HTML comments, and rebuilds each `<script>`/`<noscript>` tag as an `html_head` render element, preserving its attributes (`src`, `type`, `charset`, `data-domain-script`, etc.). Access to the form is gated by the module's own `cookiepro_settings` permission. The module has no config defaults (the config object only exists once you save the form) and is removed on uninstall. The actual consent logic, cookie scanning, banner styling and preference center all live in the external OneTrust/CookiePro service and require a CookiePro account — this module only delivers their script. There is no field, no block, and no Drush command; it is purely a head-script injector aimed at the cookie-consent use case.

---

- Add the OneTrust/CookiePro cookie-consent banner to a Drupal site by pasting one script tag.
- Show a GDPR/ePrivacy cookie consent notice on every page of a single domain.
- Load the OneTrust autoblocking SDK (`otSDKStub.js`) with your `data-domain-script` id.
- Render a preference center that lets visitors change their cookie choices.
- Inject a "Cookie Settings" button snippet that reopens the preference center.
- Embed a "Cookie List" snippet that outputs a categorized list of cookies on a policy page.
- Meet CCPA "Do Not Sell" style requirements via the OneTrust script.
- Centralize consent scripts in one Drupal config field instead of hacking the theme's `html.html.twig`.
- Deploy the consent script across environments via exported `cookiepro.header.settings` config.
- Restrict who can change the consent script using the `cookiepro_settings` permission.
- Add both `<script>` and `<noscript>` consent fallbacks in the same settings field.
- Swap the OneTrust domain script id when moving from a test to a production data domain.
- Keep the consent banner script in `<head>` so it runs before other trackers fire.
- Combine with a tag manager where OneTrust does the cookie blocking and categorization.
- Provide a cookie-compliance banner without writing any custom module code.
- Remove the consent script cleanly by uninstalling the module (config is deleted).
- Give an agency a repeatable way to drop CookiePro onto client Drupal sites.
- Update the consent script text site-wide by editing a single configuration value.
- Serve the same consent experience to all anonymous visitors from one config source.
- Audit exactly what third-party consent script a site injects by reading one config key.
