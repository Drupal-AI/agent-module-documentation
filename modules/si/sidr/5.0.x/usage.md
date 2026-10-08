Sidr provides configurable "trigger" blocks that use the jQuery Sidr library to slide a target element (typically a menu) in and out — the classic off-canvas / responsive mobile menu pattern.

---

The module ships a `sidr_trigger` block plugin plus a global settings form (`sidr.settings` at `/admin/config/user-interface/sidr`, permission `administer site configuration`) and a theme hook. You place one or more Sidr trigger blocks; each block's config form captures a jQuery source selector/URL/callback, the side (left/right), trigger text and/or icon markup, action (toggle/open/close), animation speed/timing, and options like renaming, displacement, and no-copy. On render, `template_preprocess_sidr_trigger()` JSON-encodes the block's options into a `data-sidr-options` attribute, attaches the `sidr/behaviors` library plus the selected theme library (`sidr.bare`/`light`/`dark`), and passes the global `closeOnBlur`/`closeOnEscape` flags through `drupalSettings`; `sidr.js` reads these to instantiate Sidr on click. Global settings are just the theme choice and the two close behaviors (defaults ship in `config/install/sidr.settings.yml`: dark theme, close on blur and escape). The actual jQuery Sidr JS/CSS is a third-party library you must install separately (via Composer Merge Plugin / Asset Packagist into `libraries/jquery.sidr`); the module only integrates it. No PHP dependencies beyond core.

---

- Build a responsive/mobile off-canvas menu that slides in on a hamburger tap.
- Add a slide-out panel triggered by a button placed in any theme region.
- Toggle an existing menu region into a Sidr drawer using a jQuery selector as the source.
- Open a panel from the left or right edge of the viewport.
- Load panel content from a URL or a callback instead of an on-page element.
- Show a hamburger icon and/or text label on the trigger button.
- Configure open/close/toggle behavior per trigger block.
- Set animation speed (slow/fast/ms) and CSS timing function for the slide.
- Close the panel when the user clicks outside it (close-on-blur).
- Close the panel when the user presses Escape.
- Displace page content while the panel opens/closes, targeting a chosen element.
- Use original source elements instead of copying inner HTML (no-copy mode).
- Rename source element classes/IDs when duplicating them into the panel.
- Add multiple independent Sidr panels (e.g. left menu + right cart) via multiple blocks.
- Create a dedicated close button anywhere with the `js-sidr-close` class.
- Pick a visual theme (bare / light / dark) or go bare to style with your own CSS.
- Give each panel a unique DOM id to target it from custom JS.
- Provide a lightweight jQuery-based drawer without building custom off-canvas code.
- Reuse a single trigger block config pattern across many pages via block visibility rules.
