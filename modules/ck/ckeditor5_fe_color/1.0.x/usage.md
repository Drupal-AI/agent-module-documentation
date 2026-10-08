CKEditor5 FeColor adds a configurable, class-based font-color dropdown to the CKEditor 5 toolbar so editors apply a fixed brand palette instead of arbitrary colors.

---

CKEditor5 FeColor Plugin extends Drupal's core CKEditor 5 integration with a "Fe Font Color" toolbar button whose swatches come from a predefined palette. Selecting a color wraps the chosen text in a `<span>` carrying a CSS class (e.g. `color-black`); the actual color is produced by CSS your theme or a custom module ships for that class, keeping editorial colors consistent with your design tokens. The palette is defined in code/config (in the plugin's `ckeditor5.yml`, or via `hook_editor_js_settings_alter()` and `hook_ckeditor5_plugin_info_alter()` from a custom module) — there is no color-picker or admin UI, and each palette entry is `{label, color, class, options.hasBorder}`. The plugin ships a bundled JS CKEditor 5 plugin, config schema for the palette, and an example submodule (`ckeditor5_fe_color_config_example`) demonstrating the full customization recipe. It requires only core `ckeditor5` and works on Drupal 10.1+ / 11.

---

- Give editors a locked-down brand color palette in CKEditor 5 instead of a free-form color picker.
- Enforce visual consistency by mapping colors to CSS classes tied to your design tokens (`var(--color-*)`).
- Let content authors color text (font color) from a small, curated dropdown of approved swatches.
- Keep stored markup semantic and theme-driven: colors live in CSS, not inline `style` attributes.
- Add the "Fe Font Color" button to specific text formats' CKEditor 5 toolbars (e.g. Full HTML, Basic HTML).
- Ship organization brand colors (primary, secondary, accent) as named, reusable editor swatches.
- Support light-on-light swatches with a visible border via the per-color `hasBorder` option.
- Rebrand editorial colors globally by changing one CSS class definition rather than re-editing content.
- Provide dark-mode-friendly text coloring by pointing palette classes at CSS variables that adapt per theme.
- Define palettes per text format by setting `config.fecolor.colors` in `hook_editor_js_settings_alter()`.
- Extend the default Black/White palette with additional colors from a custom module without patching this one.
- Keep new palette classes from being stripped by the HTML filter by extending the plugin's allowed `elements`.
- Load editor content CSS so authors see colors live while editing (via `ckeditor5-stylesheets` + `hook_library_info_alter()`).
- Use the `ckeditor5_fe_color_config_example` submodule as a copy-paste template for a working palette setup.
- Migrate ad-hoc inline text colors toward a governed, class-based color system.
- Standardize call-out or highlight text colors across many editors and sites.
- Support multi-brand or multi-site setups where each site's module supplies its own palette classes.
- Prevent editors from choosing off-brand or inaccessible color values by removing the free color picker.
- Round-trip existing content: spans with configured classes are recognized (upcast) and re-emitted (downcast) correctly.
- Pair with a theme's content styles so front-end and editing views render the same colors.
