<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Language Switcher adds a language item to Drupal's administration toolbar that shows the current interface language and lets you switch the current page to another enabled language.

---

The module is a tiny, configuration-free addition to the core admin `toolbar`. It implements
`hook_toolbar()` to append a `toolbar_item` (with a language icon) to the toolbar, but only for
users who hold the single permission `use toolbar_language_switcher`. The item's tab shows a
language glyph and the tray lists switch links built from the core language manager's
`getLanguageSwitchLinks(LanguageInterface::TYPE_INTERFACE, <current URL>)`, so it reflects the same
language negotiation as the standard Language Switcher block but rendered inside the toolbar and
scoped to the current page. Because it reuses the core switch-links, it honours whatever languages
are enabled and whatever URL scheme is configured (path prefix, domain, etc.). It requires the core
`language` and `toolbar` modules, ships a small CSS library and SVG language icons, and has **no
settings, no configure route, and no config schema** — the only "configuration" is granting the
permission and having more than one language enabled. The rendering logic lives in the
`tls.render.builder` service (`RenderBuilder`), which reads the current language and route to build
the tab and tray render arrays.

---

- Give editors a quick way to switch the current page to another language from the toolbar.
- Show the current interface language context at a glance while administering a multilingual site.
- Let translators jump to the same node/page in a different language without leaving the toolbar.
- Provide a toolbar language switcher only to specific roles via the `use toolbar_language_switcher` permission.
- Replace hunting for the Language Switcher block with an always-present toolbar control.
- Reflect core language negotiation (interface language) in the toolbar UI.
- Offer per-page language switching that respects path-prefix or domain language URLs.
- Add a language switcher to the admin UI without placing a block in a region.
- Help content teams verify which language variant they are currently editing.
- Speed up review of translations by switching languages in place.
- Keep the language switcher available on admin pages where blocks aren't rendered.
- Restrict the switcher to authenticated editors while hiding it from anonymous users.
- Use the shipped language icon in the toolbar for clear visual language context.
- Support any number of enabled languages, listing each as a switch link.
- Complement the standard multilingual setup (Language + Content/Config Translation).
- Provide a consistent language-switch affordance across the whole admin area.
- Enable multilingual editors to move between translations quickly during QA.
- Avoid custom theming just to expose a language switcher to admins.
- Grant the switcher to a "translator" role for a focused translation workflow.
- Show switch links only for the languages that actually apply to the current page.
