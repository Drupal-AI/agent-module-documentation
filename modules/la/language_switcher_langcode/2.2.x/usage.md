<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Switcher: Language Code replaces the full language name in core's Language Switcher block links with the uppercased language code (e.g. "English" becomes "EN"), keeping the original name as the link's title (hover) attribute.

---

This is a deliberately tiny module: one hook, no configuration, no admin page, no permission. It implements `hook_language_switch_links_alter()` and, for every link the core Language Switcher block produces, it copies the current link title (the language name) into `$link['attributes']['title']` (so the full name shows as a tooltip) and then overwrites `$link['title']` with `strtoupper($langcode)`. The result is a compact language switcher showing codes like EN / FR / DE instead of English / French / German. It depends only on core's `language` module and works anywhere core's language-switch links are rendered (the "Language switcher" block, or any code that invokes the language-switch links alter). If you need dropdowns, flags, or per-link customization, the README points to `language_switcher_extended`, `dropdown_language`, and `language_switcher_enhanced` instead — this module intentionally does one thing.

---

- Show a compact EN / FR / DE language switcher instead of full language names.
- Fit a multilingual switcher into a tight header or top bar where long names would wrap.
- Keep the full language name available as a hover tooltip (title attribute) for accessibility/clarity.
- Present a minimalist language switcher that matches a clean, icon-light design.
- Standardize the switcher to two/three-letter codes across a site with many languages.
- Avoid long strings like "Português (Brasil)" cluttering the navigation.
- Provide language codes that are recognizable to international audiences regardless of UI language.
- Reduce horizontal space used by a footer language switcher.
- Give a consistent uppercase treatment (EN, FR, ES) to switcher links for visual rhythm.
- Use codes when the theme already conveys "language" via an adjacent globe icon.
- Simplify a mega-menu language region to short tokens.
- Display langcodes in a mobile menu where full names are too wide.
- Pair with the core Language switcher block placed in a Sidebar or Header region.
- Keep switcher markup identical to core (still an `<a>` list) so existing CSS/JS keeps working.
- Swap in codes without writing a custom preprocess or template override.
- Offer hover-to-reveal full names while defaulting to compact codes.
- Roll out a codes-only switcher site-wide by just enabling one module.
- Use as a lightweight alternative when `language_switcher_extended` is more than you need.
- Show codes in a decoupled/edge case where the switcher links come from the alter hook.
- Uppercase the langcode consistently even for locale variants (e.g. `pt-br` shows as PT-BR).
