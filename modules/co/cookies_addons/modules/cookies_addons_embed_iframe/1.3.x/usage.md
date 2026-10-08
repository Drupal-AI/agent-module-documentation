<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Embed Iframe adds a "Block iframes" text-format filter that stops non-YouTube iframe embeds in formatted text from loading until the visitor consents to the built-in Iframe cookies service.

---

A submodule of Cookies Addons. It provides one `@Filter` plugin, `CookiesAddonsEmbedIframeFilter` (id `cookies_addons_embed_iframe_filter`, `TYPE_TRANSFORM_IRREVERSIBLE`). `process()` loads the text with `Html::load()`, iterates `<iframe>` elements, and for each whose `src` matches the helper `_cookies_addons_embed_iframe_is_iframe()` (a regex that matches any URL that is NOT a YouTube URL) it blanks `src`, copies the original into `data-src`, and adds the class `cookies-addons-embed-iframe`. When at least one iframe was rewritten it attaches the `cookies_addons_embed_iframe/cookies-addons-embed-iframe` JS library, which restores `data-src` back to `src` after the `iframe` cookies service is consented to (only for `http`/`https` or root-relative sources) and shows the COOKiES overlay otherwise. Installing the submodule also installs the built-in `iframe` cookies service ("Iframes other than YouTube") and the `iframes` service group. Enable the filter in a text format's configuration.

---

- Stop maps, calendars, forms and other external iframes in body text from loading before consent.
- Enable the "Block iframes" filter on any text format used by untrusted or editorial content.
- Reuse the built-in "Iframes other than YouTube" cookies service as the gate.
- Show a COOKiES consent overlay in place of the blocked iframe.
- Restore the iframe automatically once the visitor accepts the Iframe service.
- Complement the embed-video filter (which handles YouTube) so all iframe embeds are covered.
- Keep third-party iframe cookies off the page for GDPR/ePrivacy compliance.
- Gate iframes authored in CKEditor without changing the source markup permanently at rest.
- Rely on the JS protocol check so only http/https/root-relative iframe sources are re-activated.
- Install the iframe cookies service and iframes group automatically on enable.
