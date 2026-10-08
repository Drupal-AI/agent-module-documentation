<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Axeptio integrates the Axeptio.eu consent management platform: with a project id configured it loads the Axeptio SDK on every page so the consent banner/widget appears, and it can gate embedded iframes and emit Google Consent Mode v2 signals.

---

The mechanism is small and worth knowing exactly. `hook_page_attachments()` asks the `axeptio.base` service whether the module `isConfigured()` (a non-empty `id`, plus a chosen `cookies_version` when language-specific mode is on). If so it attaches the `axeptio/base` library and pushes the settings into **drupalSettings** — `clientId`, `userCookiesDuration`, `userCookiesSecure`, an optional `cookiesVersion`, and, when Google Consent Mode v2 is enabled, a `googleConsentMode.default` block of granted/denied storage signals. The bundled `assets/js/axeptio.js` copies those into `window.axeptioSettings` and injects `//static.axept.io/sdk.js` — the SDK itself comes from Axeptio's CDN, not from Drupal. Because every value travels through drupalSettings (JSON-encoded by core) rather than being concatenated into inline script, the admin-supplied id cannot break out of its string context. The second half of the module is **iframe gating**: an `axeptio_iframe` text-format filter (TYPE_TRANSFORM_REVERSIBLE) rewrites `<iframe src="…">` in filtered text into `src="" data-requires-vendor-consent="<vendor>" data-src="…"`, and the same JS restores the real `src` only after Axeptio fires `cookies:complete` for that vendor. Vendors are a plugin type (`axeptio_vendor`) with built-ins for YouTube, Google Maps and Dailymotion and an `unknown` fallback that derives a name from the host — other modules can add their own. Two operational cautions apply to any CMP: this module only gates the embeds you route through its filter (and the SDK's own tag management), so every other tracking script still has to be inventoried and held back; and consent is per visitor, so a page cached with a script tag in it is served to everyone regardless of choice — check page-cache interaction. The config form (`administer axeptio` permission) also makes a server-side call to `https://client.axept.io/<id>.json` to list the available cookie versions for the entered project id.

---

- Add the Axeptio consent banner/widget to a Drupal site.
- Load the Axeptio SDK with a configured project/client id.
- Meet a GDPR / CNIL cookie-consent requirement.
- Emit Google Consent Mode v2 default signals for Google tags.
- Set analytics_storage / ad_storage / ad_user_data / ad_personalization defaults.
- Gate YouTube embeds behind visitor consent.
- Gate Google Maps embeds behind consent.
- Gate Dailymotion embeds behind consent.
- Block arbitrary third-party iframes until consent via a text filter.
- Add a custom `axeptio_vendor` plugin for another embed provider.
- Serve a per-language cookie-version banner on a multilingual site.
- Configure cookie duration (capped at 13 months / 390 days).
- Control whether the consent cookie is HTTPS-only.
- Replace a hand-rolled cookie notice with a managed CMP.
- Keep consent tooling with an EU-based vendor.
- Provide a cookie preference centre to visitors.
- Support a privacy/tracking audit.
- Record and re-prompt consent per Axeptio project version.
- Restore the real iframe `src` only after `cookies:complete`.
- Look up available cookie versions for a project id from Axeptio.
- Render the module README on its help page (optionally via the Markdown filter).
- Centralise consent configuration behind a dedicated admin permission.
