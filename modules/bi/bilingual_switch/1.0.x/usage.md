<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bilingual Switch provides a `bilingual_switch` block that shows one link toggling between the two configured interface languages of a bilingual Drupal site.
---
Unlike the core language switcher (which lists every enabled language), this block is purpose-built for exactly two languages: `BilingualSwitchBlock::build()` fetches the interface language-switch links for the current route, and if the count is not exactly two it renders nothing. Otherwise it removes the current language and renders a single anchor pointing at the other language, preserving the current path and query string, with a configurable prefix label (default "Switch to") and a Font Awesome `fa-language` icon class.

The block declares `access` allowed only when the site `isMultilingual()` (via `blockAccess()`), sets `getCacheMaxAge()` to 0, and caches on the `languages:language_interface` and `url` contexts. Setup is: enable the module (depends on `language`), place the "Bilingual Language Switcher" block in a region, and optionally set the prefix text in the block config. It has no routes, permissions, or services of its own.
---
- Place a compact one-link language toggle in the header of a two-language site.
- Replace the verbose core language-switcher block with a single toggle link.
- Set a custom prefix such as "Ver en" or "View in" before the target language name.
- Preserve the visitor's current path when switching languages.
- Preserve query-string parameters across the language switch.
- Show a Font Awesome language icon next to the switch link.
- Hide the switcher automatically on monolingual configurations.
- Hide the switcher automatically when the page has other than two language variants.
- Style the link via the `bilingual-switch-link` CSS class.
- Target a specific language's icon via the `bilingual-switch-link-icon-<langcode>` class.
- Add the block through Layout Builder or the block layout UI.
- Restrict block visibility with standard block visibility conditions.
- Provide an accessible `title` attribute describing the switch action.
- Use on a bilingual marketing site with English/Spanish only.
- Combine with the language module's URL or session negotiation.
- Rely on the block's zero max-age to always reflect the current language.
- Ensure correct caching via the interface-language and url cache contexts.
- Override the block template/library to restyle the switcher.
- Confirm the switcher disappears if a third language is enabled.
- Translate the prefix text through the block configuration per instance.
