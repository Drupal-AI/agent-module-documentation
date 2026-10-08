<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Icons adds a small flag/icon next to each link in the core Language switcher block (and other language switch links), so visitors can recognize languages visually. It ships ~60 PNG flag icons and a settings form to control placement and size.

---

Language Icons is a spin-off from the Internationalization (i18n) package. It implements `hook_language_switch_links_alter()` to inject a themed icon into each language switch link's title. Icons are rendered through the `languageicons_link_content` theme hook (template `languageicons-link-content.html.twig`), which builds an `image` render element whose URI is derived from a configurable path pattern where `*` is replaced by the language code. On install, `languageicons_install()` sets `path` to the module's bundled `flags/*.png` set (12px-tall PNG flags). The settings form at `/admin/config/regional/language/icons` (route `languageicons.settings`, gated by the core `administer languages` permission) lets you choose icon **placement** relative to the link text (`before`, `after`, or `replace` to show only the flag), the icon **size** (`WIDTHxHEIGHT`, default `16x12`), and the icons file **path**. All settings live in the `languageicons.settings` config object. Note that the "Show on node links" / "Show on language switcher block" checkboxes are currently disabled in the form due to an upstream bug, so icons are added to language switch links whenever either flag is truthy (both default to TRUE). It requires the core `locale` module and a working Language switcher block to be visible.

---

- Add flag icons to the core Language switcher block so users spot their language at a glance.
- Show the flag before the language name (default placement).
- Show the flag after the language name.
- Replace the language name entirely with just the flag ("Replace link" placement).
- Use the module's bundled set of ~60 PNG flag icons out of the box.
- Point the module at a custom icon set by changing the icons file path (with `*` as the langcode placeholder).
- Serve SVG or differently-sized icons by overriding the path and size settings.
- Set a consistent icon size across all language links (e.g. `16x12`, `24x18`).
- Give a multilingual site a compact, flag-only language switcher in a narrow sidebar.
- Localize the language switcher visually for a global audience.
- Style the flag via the `language-icon` CSS class applied to each image.
- Override `languageicons-link-content.html.twig` in your theme to change icon/text markup.
- Provide alt/title text on each flag equal to the language name for accessibility.
- Combine with the Language switcher block placed in "Sidebar first" for a quick setup.
- Deploy icon settings across environments via exported `languageicons.settings` config.
- Configure placement/size per environment by overriding that config object.
- Use a translated title on the icon to describe the destination language.
- Present per-language flags in a header language menu.
- Keep flag height uniform (12px) while widths vary per the official flag dimensions.
- Reintroduce visual language cues that were part of the old i18n icons feature.
- Adjust the icon set to match a brand or region-specific flag design.
- Add recognizable country/language flags to improve conversion on landing pages.
