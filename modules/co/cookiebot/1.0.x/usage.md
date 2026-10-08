Cookiebot integrates the third-party Cookiebot (Usercentrics) consent service into Drupal, injecting its consent-banner script on every page from a single Domain Group ID (CBID) and optionally auto-blocking cookies until the visitor consents.

---

The module is thin glue around the hosted Cookiebot service. Its only real setting is the **CBID** (Domain Group ID, a UUID from the Cookiebot Manager); once set, `hook_page_attachments_alter()` injects the `https://consent.cookiebot.com/uc.js` script tag (placed first in `<head>`) carrying `data-cbid` plus optional `data-blockingmode="auto"`, `data-framework="IAB"`, `data-culture`, and `async`. All behaviour is driven by the `cookiebot.settings` config object: automatic cookie blocking, IAB framework, using the current Drupal language for the banner, disabling async loading, path/role/admin-theme exclusion, and an optional cookie declaration. The full **cookie declaration** can be rendered on a chosen node (via `hook_node_view_alter()`) or through the provided **Cookie declaration block**. A configurable placeholder message can be shown in place of marketing elements (iframes, etc.) that Cookiebot blocks. Two alter hooks (`hook_cookiebot_path_match_alter`, `hook_cookiebot_culture_alter`) let other modules override path exclusion and the culture code. It depends on the `js_cookie` module and exposes one permission, `administer cookiebot settings`. Because the actual consent UI, scanning, and blocking happen on Cookiebot's servers, Drupal's role here is configuration and script injection only.

---

- Add a GDPR/ePrivacy cookie-consent banner to a Drupal site using a Cookiebot subscription.
- Configure the site's Cookiebot Domain Group ID (CBID) in one place at `/admin/config/cookiebot`.
- Automatically block all cookies until the visitor gives consent (`data-blockingmode="auto"`).
- Enable the IAB Transparency & Consent Framework for advertising/vendor consent signalling.
- Show the cookie banner in the current Drupal interface language instead of browser autodetect.
- Suppress the consent script on admin pages so editors are not shown the banner.
- Exclude specific paths (e.g. `/blog/*`, `<front>`) from loading Cookiebot.
- Disable Cookiebot entirely for chosen user roles (e.g. authenticated editors).
- Render the full Cookiebot cookie declaration on a dedicated "Cookie policy" node page.
- Place the Cookie declaration block in a region to show the declaration table anywhere.
- Show a placeholder message in place of marketing iframes blocked before consent.
- Provide a "renew consent" link (URL `/cookiebot-renew`) that reopens the consent dialog.
- Disable async loading of the script to work around Safari content-blocker issues.
- Deploy consent configuration as code by exporting the `cookiebot.settings` config object.
- Keep the CBID out of markup on staging by leaving it empty (module stays inert until set).
- Signal consent language to Cookiebot per-request based on the resolved Drupal langcode.
- Programmatically force path exclusion for certain content types via `hook_cookiebot_path_match_alter`.
- Override the culture/langcode sent to Cookiebot via `hook_cookiebot_culture_alter`.
- Comply with EU/UK cookie law without hand-coding the Cookiebot embed snippet.
- Centralise consent so analytics/marketing tags load only after opt-in.
- Cache-tag the consent output (`cookiebot:cbid`) so config changes invalidate rendered pages.
- Restrict who can change consent settings with the `administer cookiebot settings` permission.
- Validate that an entered CBID matches the expected UUID format before saving.
- Swap the consent provider configuration between environments via config overrides.
