<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alternative Hreflang for SEO lets you emit a different language code in `hreflang` attributes than the one Drupal uses in URLs.

---

Sites sometimes need the `hreflang` value advertised to search engines to differ from Drupal's registered langcode — for example serving a region- or dialect-specific code (or a code search engines prefer) while keeping the existing URL langcode and routing untouched. This module stores a per-language mapping and rewrites the `hreflang` value at output time. `hook_page_attachments_alter()` walks the page's `html_head_link` alternate-language links and swaps in the mapped code (HTML-escaped), and `hook_language_switch_links_alter()` applies the same mapping to language-switcher link attributes. 403/404 pages are skipped.

Configuration is a simple admin form at **Administration → Configuration → Regional and language → Languages → Alternative Hreflang settings** (`/admin/config/regional/language/seo-alt-hreflang`), gated by the dedicated `administer seo alt hreflang configuration` permission (marked restrict access). For each installed language you enter the alternative code to advertise; blank/whitespace entries are filtered out and only differing codes are applied. It only affects the emitted markup — the registered language code, URL prefixes, and routing are unchanged.

---
- Advertise a region-specific hreflang (e.g. `en-GB`) while keeping the URL langcode `en`
- Serve a search-engine-preferred language code without re-registering languages
- Map each installed language to a custom hreflang value from one settings form
- Keep existing URL prefixes and routing unchanged while tuning hreflang
- Correct hreflang codes for better international SEO targeting
- Override the hreflang of alternate-language `<link>` tags in the page head
- Override the hreflang attribute on language-switcher block links
- Skip hreflang rewriting on 403/404 responses automatically
- Leave a language's hreflang untouched by leaving its field blank
- Apply a `zh-Hans` / `zh-Hant` style distinction not expressible as a Drupal langcode
- Restrict who can change the mapping via a dedicated permission
- Ensure emitted hreflang values are HTML-escaped
- Roll out consistent hreflang codes across a multilingual site
- Verify the change by inspecting alternate-link tags in the page source
- Avoid altering canonical URLs while fixing hreflang signals
- Use alongside core Language on any translated content