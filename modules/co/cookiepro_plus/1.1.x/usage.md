CookiePro Plus injects the CookiePro / OneTrust cookie-consent banner and Auto-Blocking script into your site's pages, driven by a Drupal admin form with per-language configuration overrides.

---

The module adds the OneTrust CookiePro consent scripts (the main OTSDKStub/otSDKStub loader plus the optional Auto-Blocking™ script and an inline Google Consent Mode default-state snippet) to the `<head>` of front-end pages via `hook_page_attachments()`. Which script is loaded is controlled by a "Script ID" (data-domain-script) and a "Script domain" (cookiepro.com vs onetrust.com) stored in the `cookiepro_plus.config` config object, with optional per-language override configs (`cookiepro_plus.config.<langcode>`) selected from URL-domain language negotiation. Injection is suppressed on admin routes, on excluded paths, when "limit to paths" is enabled and the current path is not listed, when the site is in per-config "pause mode" (a State flag toggled by admins, showing a warning to privileged users), or when the client IP matches the `ip_whitelist` (in which case the page cache is also kill-switched and a bypass library is attached). It provides three blocks (`cookiepro_plus_cookie_list`, `cookiepro_plus_consent_settings_button`, `cookiepro_plus_consent_settings_link`) and matching tokens so editors can embed the OneTrust cookie list and "open preference center" controls in content. A `CookieProGetDomainScript` event lets other modules swap the active domain script at runtime, and the central logic lives in the `cookiepro_plus` service (`Drupal\cookiepro_plus\CookiePro`). All configuration is gated behind the `administer cookiepro_plus configuration` permission (restricted).

---

- Add the OneTrust CookiePro consent banner to a Drupal 11 site by entering a Script ID.
- Serve the consent script from the cookiepro.com or onetrust.com CDN domain.
- Enable CookiePro Auto-Blocking™ so third-party cookies are blocked until consent.
- Turn on Google Consent Mode and set the default denied storage states (ad_storage, analytics_storage, etc.).
- Auto-detect the document language for the banner from the HTML page.
- Maintain separate CookiePro configurations per language via URL-domain language negotiation overrides.
- Restrict the banner to a specific list of paths ("limit to paths").
- Exclude specific paths (e.g. node edit, previewer, embed preview) from receiving the script.
- Whitelist internal/QA IP ranges so the banner is bypassed and the page cache is disabled for them.
- Put a configuration into "pause mode" to temporarily stop injecting the script without deleting settings.
- Warn administrators on-page when a configuration is paused, with a link to re-enable it.
- Test whether the configured Script ID and Auto-Blocking scripts are actually published to the CDN.
- Use a testing CDN variant of the script (appends `-test` to the Script ID) for staging.
- Embed the OneTrust cookie list into a page or block with the `cookie_list` token/block.
- Add an "open cookie preferences" button anywhere using the consent-settings button block/token.
- Add an inline "cookie settings" text link using the consent-settings link block/token.
- Map the five OneTrust cookie category IDs (Strictly Necessary … Social Media) used for CSS/consent classes.
- Integrate with Google Tag Manager (via the suggested `google_tag` module) behind consent.
- Alter the active domain script programmatically per request with the `CookieProGetDomainScript` event.
- Ensure banner markup is cached correctly by attaching the config's cache tags.
- Keep the consent script out of the admin UI so editors are never nagged.
- Provide GDPR/ePrivacy cookie-consent compliance backed by OneTrust's scanning and category data.
