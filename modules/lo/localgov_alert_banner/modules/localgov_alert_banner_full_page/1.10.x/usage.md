<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Full page Alert Banner is a submodule of LocalGov Alert Banner that adds a full-screen takeover alert banner for the most urgent messages.

---

Enabling the submodule installs a `localgov_full_page` alert-banner bundle alongside the default one, with its own fields — `localgov_alert_banner_body` (rich text), `localgov_alert_banner_image`, `link`, `type_of_alert` and `visibility` — plus its own form and view displays. It renders through a dedicated template `localgov-alert-banner--localgov-full-page.html.twig` and a `full_page_alert_banner` library that ships layout and theme CSS (`full-page-alert-banner-layout.css`, `full-page-alert-banner-theme.css`) and `full-page-alert-banner.js`. `ThemeHooks::preprocessLocalgovAlertBannerFullPage()` assigns a unique wrapper id to each rendered banner (`Html::getUniqueId()`) and passes it to the JavaScript through `drupalSettings` so the script can target that instance. Because full-page banners can include an image, the submodule depends on `localgov_core`'s `localgov_media`. Everything else — the entity, the manager, moderation, permissions and the block — is inherited from the parent module; this submodule only adds the full-page bundle and its presentation.

---

- Display a full-screen takeover alert for the most critical incidents.
- Add an image to a full-page emergency message.
- Use rich-text body content in a takeover banner.
- Give a full-page alert its own template and styling.
- Distinguish a full-page takeover from the inline banner bundle.
- Include a call-to-action link on the full-page banner.
- Restrict a full-page banner to selected pages with visibility conditions.
- Reuse the parent moderation workflow for full-page banners.
- Target a specific banner instance from JavaScript via its unique id.
- Theme the full-page layout separately from the inline banner.
- Publish a national-emergency style interstitial message.
- Keep full-page and inline alerts as separate banner types.
