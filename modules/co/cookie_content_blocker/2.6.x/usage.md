<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Content Blocker prevents privacy-impacting content (embeds, tracking pixels, third-party scripts) from loading until the visitor gives cookie consent. It wraps the original markup in an inert `<script type="text/plain">` placeholder with an optional message and "Show content" button, and reveals it once a *separate* cookie consent manager reports consent.

---

The module does not manage consent itself — it needs a separate consent manager (e.g. Klaro, Cookiebot, or any script that sets a cookie / fires an event). It blocks content three ways: (1) a **text filter** (`cookie_content_blocker_filter`) that turns a custom `<cookiecontentblocker>…</cookiecontentblocker>` tag (insertable via the bundled CKEditor 5 button) into a blocked placeholder; (2) a render-array property `#cookie_content_blocker` you add in code/preprocess to any element; (3) the **Media** submodule's oEmbed formatter that blocks remote media per provider. Blocking works by moving the original HTML into a `<script type="text/plain">` tag (so browsers never fetch its images/iframes/scripts) with any inner `<script>` renamed to `<scriptfake>`; the front-end JS (`js/cookieContentBlocker.js`, depending on `js_cookie`) swaps the real content back in when consent is detected. A global settings form controls the default blocked message, whether a button shows, the button text, click-to-consent behaviour, and "consent awareness" (which cookie/event signals acceptance, decline, or change). **Cookie categories** are config entities that let different content types map to different consent signals and messages. Per-element settings can be overridden inline through the filter tag's base64/JSON `data-settings` attribute. Element processing is extensible via services tagged `cookie_content_blocker_element_processor`.

---

- Block a YouTube/Vimeo embed in body text until the visitor accepts marketing cookies.
- Insert a "cookie content blocker" region in CKEditor 5 around any HTML and show a consent placeholder.
- Block a Google Maps iframe pasted into a WYSIWYG field.
- Prevent tracking pixels / social widgets from loading before consent.
- Show a custom "Accept cookies to view this content" message per blocked block.
- Add a "Show content" button that reveals the blocked content on click.
- Let clicking anywhere on the placeholder count as consent (`enable_click_consent_change`).
- Wire the module to an existing consent manager by mapping its accept/decline/change cookie or DOM event ("consent awareness").
- Create cookie **categories** (e.g. "marketing", "statistics") with their own message/button and consent signals.
- Assign blocked content to a category so it reveals only when that category is accepted.
- Block a remote media entity (oEmbed) per provider via the Media submodule.
- Show a thumbnail preview behind the consent message for blocked media.
- Block content programmatically by adding `#cookie_content_blocker => TRUE` to a render array.
- Override the message/button/category for one element via the render property options.
- Localise the blocked message and button text (config translation supported).
- Translate cookie category messages per language.
- Block an arbitrary render element's attached JS/CSS libraries until consent (AttachedProcessor).
- Provide a GDPR/ePrivacy-compliant embed experience without hard-coding placeholders in templates.
- Add a custom element processor service to change how blocked elements are built.
- Wrap a third-party `<script>` snippet so it does not execute until consent.
- Reveal blocked content automatically (no button) once the consent cookie appears.
- Feed inline per-tag settings (message, category) through the filter's `data-settings` attribute.
- Keep block-level cache correct by depending on the category config entity.
- Migrate a CKEditor 4 cookiecontentblocker setup to CKEditor 5 (upgrade plugin included).
