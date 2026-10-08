Language Switcher Dropdown (lang_dropdown) exposes a block that lets visitors switch site language through a `<select>` dropdown instead of the plain list of links provided by core's Language Switcher block.

---

The module registers a single block plugin, `language_dropdown_block`, derived per configurable language type (e.g. `language_dropdown_block:language_interface`). You place the block through core's Block layout UI (Structure > Block layout) and configure it in the block form; there is no dedicated settings page — the `configure` route is `block.admin_display`. Each placed block is a `block` config entity whose `settings` mapping stores the widget style and display options. The `widget` (output type) picks how the dropdown is rendered: `0` Simple HTML select, `1` Marghoob Suleman msDropdown, `2` Chosen, `3` ddSlick. The `display` (format) picks the label shown for each language: `0` translated into the current language, `1` language native name, `2` language code, `3` translated into the target language. Additional booleans control behaviour: `showall` (list languages even without a translation), `hide_only_one` (hide the block when a single language is available), and `tohome` (redirect to the front page on switch). It integrates with the Language Icons module to show flags, and the fancier output types (msDropdown, Chosen, ddSlick) require their JS libraries to be present. It depends only on core's `language` module.

---

- Replace the core Language Switcher's link list with a compact dropdown select in a sidebar or header.
- Let visitors change interface language from a single-click dropdown on multilingual sites.
- Show each language in its own native name (Deutsch, Espanol, Francais) via `display: 1`.
- Show ISO language codes (en, de, fr) in the switcher via `display: 2`.
- Show language names translated into the currently active language via `display: 0`.
- Show language names translated into their own target language via `display: 3`.
- Render the switcher as a plain accessible HTML select with no JS dependency (`widget: 0`).
- Render a styled searchable dropdown using the Chosen library (`widget: 2`).
- Render an animated dropdown with the Marghoob Suleman msDropdown library (`widget: 1`).
- Render a dropdown with flag thumbnails using the ddSlick library (`widget: 3`).
- Add flag icons beside each language by installing the Language Icons module.
- Constrain the dropdown to a fixed pixel width with the `width` setting.
- List every enabled language even where a page has no translation (`showall: 1`).
- Automatically hide the switcher when only one language is available (`hide_only_one: 1`).
- Redirect visitors to the front page whenever they switch language (`tohome: 1`).
- Place separate dropdowns for interface language and content language types where both are configurable.
- Hide specific languages from the dropdown for specific user roles (`hidden_languages`).
- Offer a mobile-friendly language selector that takes less vertical space than a link list.
- Provide a header language selector matching a theme's form styling.
- Disable the Chosen search box for short language lists (`chosen.disable_search`).
- Position the flag before or after the language name when Language Icons is enabled.
- Give editors a familiar select control for switching languages in the admin theme.
- Build a country/language chooser landing experience with the ddSlick flag output.
- Swap in a rounded, animated msDropdown skin for a branded switcher.
- Keep the switcher accessible by falling back to a native select for keyboard/screen-reader users.
- Show the switcher only on translated content by leaving `showall` off.
- Reuse the same block across multiple regions or themes with different widget styles.
