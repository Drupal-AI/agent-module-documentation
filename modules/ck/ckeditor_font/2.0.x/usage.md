CKEditor Font adds Font Family, Font Size, Font Color, and Font Background Color dropdowns to the CKEditor 5 toolbar, each with a per-text-format list of allowed values applied as inline `<span style>` styles.

---

CKEditor Font registers three CKEditor 5 plugins for Drupal's CKEditor 5 integration: a combined Font Size & Family plugin (`ckeditor_font_font`, buttons `fontSize` and `fontFamily`), a Font Color plugin (`ckeditor_font_font_color`, button `fontColor`), and a Font Background Color plugin (`ckeditor_font_font_background_color`, button `fontBackgroundColor`). You enable the buttons per text format by dragging them into the CKEditor 5 toolbar at **Admin → Configuration → Content authoring → Text formats and editors**, then configure the allowed values in the plugin settings that appear below the toolbar. Font families are entered one per line as comma-separated stacks (`Verdana, Geneva, sans-serif`) and the label is derived from the first family; font sizes use `123px|Size label` syntax (also `em`, `%`, `pt`, `rem` and CSS size keywords); colors use `rgb(255,255,255)|Label`, `hsl(0,0%,0%)|Label`, or `#ff0000|Label` syntax, with configurable column count and a document-colors limit. When no list is provided the Font Size & Family plugin falls back to built-in defaults (sizes tiny/small/default/big/huge; a standard serif/sans-serif/monospace family list). Two "Support all values" checkboxes let pasted content keep font-size / font-family values outside the configured list instead of stripping them. All plugins declare `<span>` and `<span style>` as their allowed HTML elements so the inline styles survive filtering, and a CKEditor 4→5 upgrade plugin maps the old `Font`/`FontSize` buttons and settings to the new plugins. The module provides config schema for all settings. This 2.0.x release is a beta; the project README marks the module as deprecated in favor of the CKEditor5 Plugin Pack module for new sites.

---

- Add a Font Family dropdown to a rich-text editor so authors can pick from an approved list of typefaces.
- Add a Font Size dropdown offering a curated set of sizes (e.g. 10px Normal, 20px Medium, 30px Large).
- Add a Font Color picker to let editors color selected text inline.
- Add a Font Background Color (highlight) picker for selected text.
- Restrict the available fonts per text format so Basic HTML and Full HTML can differ.
- Define font-size options in `px`, `em`, `%`, `pt`, or `rem` units.
- Use CSS size keywords like `small`, `large`, or `x-large` as font-size values.
- Provide human-friendly size labels (`20px|Medium Size`) shown in the dropdown.
- Present font families as comma-separated fallback stacks (`Lucida Console, Courier New, monospace`).
- Rely on the built-in default font and size lists when you don't want to curate one.
- Allow pasted content to keep arbitrary font sizes by enabling "Support all Font Size values".
- Allow pasted content to keep arbitrary font families by enabling "Support all Font Family values".
- Set the number of columns shown in the font-color swatch dropdown.
- Cap or disable the "document colors" recently-used swatches with the maximum-colors setting.
- Define a brand palette of approved text colors for editors to choose from.
- Keep inline `<span style>` markup from being stripped by the text format's HTML filter.
- Migrate a CKEditor 4 site's Font/FontSize buttons and settings to CKEditor 5 automatically.
- Give marketers limited typographic control without exposing full custom CSS.
- Export the font/size/color configuration as part of a text format's config for deployment.
- Enforce a consistent, small set of sizes so body copy stays visually uniform.
- Let editors apply monospace styling to inline code-like snippets.
- Offer a highlight color to draw attention to key phrases in content.
- Standardize typography across authors by locking the family list per format.
- Combine size and family control in a single plugin toggle on the toolbar.
- Provide accessible labelled size choices instead of raw pixel values.
- Transition legacy sites off CKEditor 4 font tooling while keeping existing markup.
