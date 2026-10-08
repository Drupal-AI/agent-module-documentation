<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Content Blocker — agent index

Blocks privacy-impacting content (embeds, pixels, scripts) until cookie consent is given, by
moving the original HTML into an inert `<script type="text/plain">` placeholder that front-end JS
un-hides when a **separate** consent manager reports consent. Depends on `js_cookie`.
`configure` = `cookie_content_blocker.settings`. Provides permissions, a config schema, a text
filter, a CKEditor 5 button, and a `cookie_content_blocker_category` config entity.

- **Global settings, the filter, CKEditor button, cookie categories, consent-awareness mapping** →
  [configure/settings.md](configure/settings.md)
- **Block content in code: the `#cookie_content_blocker` render property, the `<cookiecontentblocker>`
  filter tag + `data-settings`, custom element processors, drupalSettings** →
  [api/blocking.md](api/blocking.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodule (own docs):
- `cookie_content_blocker_media` (block remote oEmbed media per provider) →
  [../../modules/cookie_content_blocker_media/2.6.x/agent/start.md](../../modules/cookie_content_blocker_media/2.6.x/agent/start.md)

Key facts:
- Blocking mechanism: `cookie-content-blocker-wrapper.html.twig` emits the original content inside
  `<script class="js-cookie-content-blocker-content" type="text/plain">`; inner `<script>`→`<scriptfake>`
  (regex in `cookie_content_blocker_element_original_content()`), so nothing loads until JS swaps it back.
- No consent logic of its own — you MUST map an external consent manager under "consent awareness".
- Blocked HTML is passed through as-is (`Markup::create`); the filter relies on **other text-format
  filters** to sanitize it (`TYPE_TRANSFORM_IRREVERSIBLE`, run it last). See api/blocking.md.
