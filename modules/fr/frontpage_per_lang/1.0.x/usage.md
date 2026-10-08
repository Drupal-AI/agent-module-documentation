<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Frontpage Per Language lets a multilingual site serve a different front page for each language by storing a per-language front path and resolving `/` to it at runtime.

---

The module hooks core's Basic site settings form to add one "Default front page" textfield per non-default language (only when more than one language exists). Entered paths are validated (must start with `/`, must be a valid, accessible path) and saved into `system.site` as `page.front_<langid>` — the langcode with hyphens removed (so `pt-br` becomes `page.front_ptbr`).

At request time two service decorators do the work: `PathProcessorAlter` decorates `path_processor_front` and rewrites an inbound `/` to the language-specific front path when the current content language is not the default; `PathMatcherAlter` decorates `path.matcher` so `isFrontPage()` correctly recognises the per-language front path (keeping front-page block visibility and caching accurate). Additionally, `hook_page_attachments` emits `hreflang` alternate links for every language on the front page. There is no separate admin route or permission beyond core's `administer site configuration` on the site information form.

---

- Set a distinct front page node/view for each language
- Serve a translated landing page at `/` per language
- Keep the default language's front page from core unchanged
- Configure the per-language front path from Basic site settings
- Validate that each per-language path exists and is accessible
- Emit hreflang alternate links on the front page for SEO
- Ensure front-page-only blocks show on the language front page
- Point `pt-br`, `de`, etc. each to their own landing content
- Use a different view as the front page for a specific language
- Rely on URL-prefix negotiation to pick the right front page
- Redirect `/` to a language-appropriate path transparently
- Review stored values under `system.site` `page.front_<langid>`
- Support any number of configured languages
- Change a language's front page later by editing site settings
- Keep front-page caching correct via the path.matcher decorator
- Provide localized home pages without custom code
