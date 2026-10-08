YouTube Cookies blocks embedded YouTube videos from loading (and setting tracking cookies) until the visitor has consented, replacing each video with a thumbnail façade and a consent pop-up wired to your cookie-compliance system (OneTrust or EU Cookie Compliance).

---

On every page (when enabled) the module scans rendered fields for YouTube iframes and neutralizes them by moving the `src` into a `data-src` and blanking `src`, then adds a façade (thumbnail + play icon) and a JS-driven consent pop-up. Three embedding paths are covered: core **Media oembed** field formatter, the contrib **Iframe** field type (both via `hook_preprocess_field`), and rich-text **CKEditor** content (via the `youtube_cookies_wysiwyg_filter` text-format filter that rewrites `<iframe>` tags with `Html::load()`/DOMXPath). A settings form at `/admin/config/system/youtube-cookies` (permission `administer site configuration`) configures: the **cookie category** machine name that must be accepted, the **provider** (`onetrust` or `eu_cookie_compliance`, which selects the matching JS integration library), the **action** when there is no consent (`popup` — GDPR-compliant blocking pop-up; or the deprecated `no_cookies_domain` youtube-nocookie.com fallback), and the pop-up message and button labels (all config-translatable). When category + provider are set, `hook_page_attachments` attaches the JS library and passes the settings (rendered markup for the message/buttons/thumbnail) via `drupalSettings`. The filter enforces that Full HTML/`filter_html` formats keep `<iframe>` with a `class` attribute allowed. No permissions of its own, no Drush, no submodules.

---

- Stop embedded YouTube videos from setting cookies before the visitor consents.
- Show a thumbnail + play-button façade in place of a blocked YouTube video.
- Display a GDPR-compliant consent pop-up when a visitor clicks a blocked video.
- Integrate consent with an existing OneTrust cookie banner.
- Integrate consent with the EU Cookie Compliance module.
- Gate video playback on a specific cookie-category machine name being accepted.
- Block YouTube videos embedded via core Media oembed fields.
- Block YouTube videos added through the contrib Iframe field type.
- Block YouTube iframes pasted into CKEditor/rich-text content via the text-format filter.
- Customize the consent pop-up message shown over blocked videos.
- Customize the Manage / Accept / Exit button labels.
- Translate the pop-up message and buttons per language (config translation).
- Temporarily disable all façade behavior with a single "enabled" toggle.
- Fall back to the youtube-nocookie.com domain (deprecated) instead of a pop-up if required.
- Meet cookie-consent obligations for sites embedding third-party YouTube media.
- Ensure `<iframe class>` is allowed when enabling the filter on a text format (enforced on save).
- Layer YouTube consent handling on top of oembed_lazyload when that module is present.
- Provide a consistent consent UX across oembed, iframe-field, and WYSIWYG-embedded videos.
