<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Untranslated 404 returns a 404 when someone requests an entity in a language it has not been translated into, instead of silently serving the original language.

---

Drupal's default is language fallback: ask for `/fr/node/12` when node 12 exists only in English and you get the English content at a French URL. That is a reasonable default for a site where partial translation is expected, and wrong in two situations that matter. For SEO, it creates duplicate content across language URLs and tells search engines a French page exists when it does not, which dilutes indexing and can surface the wrong result in the wrong market. For editorial correctness, a visitor on a French URL reasonably expects French, and being handed English without explanation is worse than a clean "not found" that leads them to the language switcher. This module makes the second behaviour available: an untranslated entity in the requested language returns the 404 page. It depends on core `content_translation` and targets `^10 || ^11`. The decision it forces is a policy one worth making deliberately — for a site translating everything, 404 is right; for one translating selectively, fallback may serve visitors better, and the two are not interchangeable.

---

- Return 404 for untranslated pages.
- Avoid duplicate content across languages.
- Stop serving English at a French URL.
- Improve multilingual SEO.
- Make partial translation visible.
- Signal missing translations clearly.
- Avoid misleading search engines.
- Support a fully-translated site policy.
- Reduce confusion for visitors.
- Prevent language fallback.
- Support a market-specific site.
- Clean up hreflang consistency.
- Detect gaps in translation coverage.
- Support a regulated multilingual requirement.
- Improve analytics accuracy per language.
- Direct visitors to the language switcher.
- Avoid indexing untranslated URLs.
- Enforce a translation completeness rule.
