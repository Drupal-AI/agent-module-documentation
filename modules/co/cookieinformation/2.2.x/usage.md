Cookie Information integrates a Drupal site with the third-party Cookie Information (cookieinformation.com) consent platform, injecting its consent popup script, with optional Google Consent Mode (v1/v2), IAB TCF, and client-side iframe blocking until consent is given.

---

The module attaches the Cookie Information consent script (`https://policy.app.cookieinformation.com/uc.js`) to every page via `hook_page_attachments_alter()`, tagging it with the current interface language (mapped/validated to Cookie Information's supported culture list by `LanguageService`). A single settings form at `/admin/config/system/cookie-information` (route `cookieinformation.settings`, permission `administer cookie information settings`) controls: enabling the popup, IAB TCF data-attributes, Google Consent Mode version (`v1`/`v2`, which also embeds an early inline `consent_mode*.init.js` and loads the matching library), and iframe blocking. When iframe blocking is on, `js/iframes.js` rewrites third-party iframe `src` to `data-consent-src` (with a `data-consent-category`, default *functional*) so they load only after the user accepts the chosen cookie category. A `VisibilityService` decides on each request whether to emit the popup, honoring exclude-paths (with wildcards/alias matching), exclude-admin-routes, exclude-UID-1, and a `disable cookie information consent` permission (any non-UID-1 role holding it skips the popup). Two blocks — Cookie Policy (`cid.js` embed) and Privacy Controls (`#cicc-template` container) — render the platform's policy table and re-consent controls. The module requires an active Cookie Information subscription/template configured on their platform; it ships no secret and injects only fixed vendor script URLs.

---

- Add a GDPR/ePrivacy cookie consent banner backed by the Cookie Information platform.
- Load the consent popup site-wide with the correct language/culture automatically.
- Enable Google Consent Mode v2 (advanced mode) so Google tags respect the user's consent choices.
- Enable Google Consent Mode v1 for legacy analytics consent signaling.
- Turn on IAB TCF v2.2 support for ad-tech vendors that require the framework.
- Block third-party iframes (YouTube, Vimeo, maps) until the visitor accepts the relevant cookie category.
- Choose which cookie category (functional/marketing/statistic) gates blocked iframes.
- Show a placeholder over blocked iframes that lets the user open the consent banner to unblock them.
- Hide the consent popup on admin pages so editors aren't interrupted.
- Hide the consent popup for the superuser (UID 1).
- Exclude specific paths (with wildcards, alias-aware) from showing the consent popup.
- Grant a role the `disable cookie information consent` permission to suppress the popup for logged-in staff.
- Place a Cookie Policy block that renders Cookie Information's cookie declaration table on a policy page.
- Place a Privacy Controls block so users can reopen and change their consent choices.
- Localize the consent widget to any of Cookie Information's supported languages, with `no`/`nn` mapped to `nb`.
- Fall back to English automatically when the site language isn't supported by the platform.
- Centralize consent management for a multilingual site through one integration.
- Meet cookie-consent compliance requirements without hand-coding the vendor snippet into a template.
- Keep the consent script early in the page load (GCM init injected with weight -200) for correct tag gating.
- Restrict the settings form to trusted admins via the `administer cookie information settings` permission.
