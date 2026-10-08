<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure adsense_consent

Settings form: **Configuration → Services → AdSense Consent** (`/admin/config/services/adsense-consent`, permission *administer site configuration*). All values live in config `adsense_consent.settings`.

Key settings:
- `pubid` — AdSense publisher ID, must match `/^pub-[0-9]+$/`; ads emit only when valid.
- `page_ads` — enable page-level (auto) ads.
- `personalise` — default personalisation state (0 = non-personalised).
- `wait_consent` / `wait_eu_cookie_compliance` / `wait_klaro` (+ `wait_klaro_service_name`) — which consent gate must pass before personalised ads load.
- `providers` — newline-separated `Name, https://url` list rendered on `/ad-options` (parsed by `Helper::providerRegex()`).
- Rich-text fields (`page_text_ask_consent`, `page_text_personalise`, `page_text_no_personalise`, `page_text_footer_p`, `page_text_footer_no_p`) rendered with `check_markup()`.

Ads are wired client-side: `adsense_consent_page_attachments()` sets `drupalSettings.adsenseConsent` and attaches libraries `google_adsense`, `apply_personalisation_prefs`, `apply_consent_prefs`, and (if `page_ads`) `page_level`. Place the **AdSense** block (`Plugin\Block\AdsenseBlock`) for a fixed unit. The public `/ad-options` page lets visitors read the explanation and toggle preferences (stored in the `ad_consent` cookie by JS).
