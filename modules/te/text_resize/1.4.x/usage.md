<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text Resize provides a block with "A-" / "A+" (and optional reset) links that let site visitors increase or decrease the font size of a chosen part of the page, remembered client-side via JavaScript.

---

The module defines a single block plugin, `text_resize_block` (admin label "Text Resize"), that you place in a region like any other block. The block renders `+A` / `-A` links (and a reset `A` link when enabled) via the `text_resize_block` theme hook (template `text-resize-block.html.twig`, with `template_preprocess_text_resize_block()` building the markup) and attaches the `text_resize/text_resize.resize` library. All behavior is driven from one config object, `text_resize.settings` (settings form at route `text_resize_settings`, `/admin/config/user-interface/text_resize`, permission `administer text_resize`): `text_resize_scope` is the CSS selector/class/id/tag whose text is resized (default `main`), `text_resize_minimum` / `text_resize_maximum` bound the font size in pixels (default 12–25), `text_resize_reset_button` toggles the reset link, and `text_resize_line_height_allow` with `text_resize_line_height_min` / `_max` optionally also adjust line height. Those values are passed to the front-end script as `drupalSettings.text_resize`. The module has no dependencies beyond core (it uses the Block system), no Drush commands, and no plugin types of its own; look-and-feel is customised by overriding the block CSS ids (`#text_resize_increase`, `#text_resize_decrease`, `#text_resize_reset`) or the theme function.

---

- Add an on-page font-size control so visitors can enlarge text for readability.
- Give low-vision users an accessible "bigger/smaller text" widget without browser zoom.
- Place the Text Resize block in a header or sidebar region via Block Layout.
- Limit resizing to the main content area by setting the scope selector (default `main`).
- Resize only a specific container by entering its CSS id (e.g. `my-container`) as the scope.
- Set the smallest allowed font size (default 12px) so text never gets unreadably small.
- Set the largest allowed font size (default 25px) to cap how big text can grow.
- Add a reset button so users can return text to the default size in one click.
- Also adjust line height as text grows by enabling the line-height option and its min/max.
- Provide an accessibility toolbar element alongside contrast or language controls.
- Style the resize links to match a theme by overriding `#text_resize_increase` / `#text_resize_decrease` CSS.
- Restrict who can change the resize settings with the `administer text_resize` permission.
- Configure all behavior from `/admin/config/user-interface/text_resize`.
- Deploy the resize configuration as exported `text_resize.settings` config.
- Offer text sizing on a public site without requiring users to know browser zoom shortcuts.
- Apply resizing to `body` for a whole-page effect by setting the scope to `body`.
- Customise the rendered HTML via a `template_preprocess_text_resize_block()` override.
- Keep the chosen size across page interactions using the module's client-side script.
- Add a font-size control to a government/public-sector site for WCAG-friendly reading.
- Pair with a high-contrast theme switcher to build a simple accessibility widget set.
- Show the reset control only where needed by toggling the reset-button setting per environment.
- Give editors a no-code way to add reader font controls by just placing a block.
