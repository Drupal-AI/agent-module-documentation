Advanced Language Selector provides a single configurable block ("Advanced language selector block") that renders a styled language switcher with flag icons, in one of eight built-in display styles (Bootstrap dropdown, navigation, modal, offcanvas, list-group, button-group, plus plain HTML select and plain HTML list).

---

The module registers one Block plugin (`advanced_language_selector_block`) whose configuration form is generated dynamically from YAML "style" definitions in `config/styles/*.yml`. Each style (dropdown, navigation, modal, offcanvas, list-group, button-group, plain HTML, plain HTML list) declares its own tree of form fields — component id, custom CSS classes, text transformation, and per-item display options (show icons / language code / language name, flag icon height, icon alignment) — which the block form builder walks recursively. A `StyleManager` service scans the style YAML files and the `style_selector.yml` to build the "Look and Feel" theme selector. At render time `build()` calls core's `getLanguageSwitchLinks()`, augments each link with a flag icon path, language code, and a translated URL, then themes it through the style's `block--language-selector--<style>.html.twig` template. Flag icons are ~269 bundled SVGs in `assets/flags/`, mapped from langcode to country code by `src/Langcodes.php` (with a `no-flag.svg` fallback). The block is only visible on multilingual sites (`blockAccess` checks `isMultilingual()`) and sets `getCacheMaxAge(0)`. Bootstrap styles can optionally attach an external Bootstrap 5 + Popper CDN library for non-Bootstrap themes. The module has no dependencies, no permissions, no routes, and no configuration page — everything is configured in the block's settings form when you place the block.

---

- Place a language switcher block styled as a Bootstrap dropdown.
- Add a language switcher rendered as Bootstrap nav tabs.
- Show languages in a Bootstrap modal triggered by a button.
- Show a language switcher in a Bootstrap offcanvas panel.
- Render languages as a Bootstrap list-group.
- Render languages as a Bootstrap button-group.
- Use a plain HTML `<select>` language switcher with no Bootstrap.
- Use a plain HTML `<ul>` list of language links.
- Display country flag icons next to each language.
- Show only flag icons with no text.
- Show the language code (e.g. EN, ES) beside each flag.
- Show the full language name (e.g. English, Español).
- Control flag icon height in pixels per style.
- Align flag icons to the left or right of the label.
- Apply upper/lower/capitalize text transformation to labels.
- Add custom CSS classes to the selector or the selected item.
- Style the selected/active item differently (e.g. `btn-primary`).
- Load Bootstrap 5 from CDN when the site theme is not Bootstrap-based.
- Hide the switcher automatically on single-language sites.
- Provide a flag-based switcher that links to translated node URLs.
- Give agents a drop-in multilingual switcher without writing a theme template.
- Override a style's Twig template in a custom theme for full markup control.
- Swap or extend the bundled flag SVGs for custom flag artwork.
