<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hides email addresses from spam-bots by obfuscating them, exposed four ways: an Email-field formatter, a text-format filter, a Twig filter/function, and a service — with two obfuscation methods (HTML-entity encoding, or ROT13 + reversed-text with a CSS/JS fallback).

---

Obfuscate turns plain email addresses into markup that spam harvesters have a hard time reading
but that renders normally to humans. A single system-wide **method** is chosen at
`/admin/config/obfuscate` (config `obfuscate.settings:obfuscate.method`, default `html_entity`)
and used by the text filter, the Twig extension, and the `obfuscate_mail` service; the field
formatter defaults to that method but can be overridden per field instance. The **HTML-entity**
method (`ObfuscateMailHtmlEntity`) randomly encodes ~25% of characters (and always `.`/`@`/`:`)
into decimal/hex HTML entities and URL-encodes the `mailto:` href, adding `rel="nofollow"`. The
**ROT13** method (`ObfuscateMailROT13`, adapted from the Propaganistas library) emits a
`js-enabled` span with the ROT13-rotated address plus a `js-disabled` span with the reversed
address as a no-JS CSS fallback; `js/rot13.js` (library `obfuscate/rot13`) rotates it back and
rebuilds a real `mailto:` link in the browser. Delivery mechanisms: the `obfuscate_field_formatter`
formatter for `email` fields (with an optional token-enabled link label), the `obfuscate_mail`
text filter (id `obfuscate_mail`, a `TYPE_TRANSFORM_IRREVERSIBLE` filter you enable on a text
format, with regex ported from SpamSpan that handles bare addresses and `mailto:` links and runs
`Xss::filter` on its output), and a Twig `TwigExtension` providing the `|obfuscateMail` filter and
`obfuscate()` function. A `administer obfuscate` permission gates the settings form. It is an
obfuscation aid, not encryption — determined scrapers can still parse addresses.

---

- Display an Email field as an obfuscated `mailto:` link via the "Obfuscate" formatter.
- Enable the obfuscation filter on Full HTML / Basic HTML so all addresses in body text are hidden.
- Obfuscate an email inside a Twig template with `{{ 'a@b.com'|obfuscateMail }}`.
- Print an obfuscated link with custom text via the `obfuscate('a@b.com', 'Email us')` Twig function.
- Obfuscate an address from custom code through the `obfuscate_mail` service.
- Choose HTML-entity encoding as a pure-PHP, no-JavaScript obfuscation method.
- Choose ROT13 + reversed-text so the real address never appears in the raw HTML source.
- Add `rel="nofollow"` automatically to obfuscated mailto links (HTML-entity method).
- Override the obfuscation method per Email field instance (formatter setting).
- Use a token-replaced custom link label instead of showing the raw address as link text.
- Provide a no-JS CSS fallback (reversed text) for the ROT13 method.
- Reduce spam to contact addresses published on high-traffic pages.
- Keep author/contact email fields readable to users but opaque to harvesters.
- Set one site-wide default method and let editors rely on it via the text filter.
- Obfuscate addresses in WYSIWYG content without editors doing anything special.
- Restrict who can change the obfuscation method with the `administer obfuscate` permission.
- Handle `mailto:` links with subject/body query strings in filtered text.
- Keep inline base64 images intact while filtering (they are placeholdered around the regex).
- Signal search engines to ignore obfuscated addresses (nofollow / hidden markup).
- Swap in ROT13 to defeat simple HTML-entity-decoding scrapers.
- Apply obfuscation consistently across field display, body text, and templates from one setting.
- Migrate from SpamSpan-style filtering to a lighter built-in obfuscation filter.
