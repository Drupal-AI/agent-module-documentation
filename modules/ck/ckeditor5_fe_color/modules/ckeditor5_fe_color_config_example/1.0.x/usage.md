A reference submodule of CKEditor5 FeColor that registers an example four-color palette and editor CSS entirely through Drupal hooks, serving as a copy-paste template for real palettes.

---

CKEditor5 FeColor Config Example is a small, working demonstration module for the CKEditor5 FeColor plugin. It ships no UI, routes, or config entities; instead its `.module` file implements three hooks that together show the recommended way to configure FeColor from a custom module: `hook_editor_js_settings_alter()` sets a palette (Black, White, Red, Green) on the `basic_html` text format, `hook_ckeditor5_plugin_info_alter()` extends the FeColor plugin's allowed `<span class="…">` elements so the palette classes survive HTML filtering, and `hook_library_info_alter()` loads the module's `ckeditor5-stylesheets` CSS into the editing view. Enable it to preview the pattern, or copy its `.module`, `.info.yml`, and `css/ckeditor5.css` into your own module to define a production palette. It depends on `ckeditor5_fe_color` and runs on Drupal 10 / 11.

---

- Learn the recommended pattern for configuring the FeColor palette from a custom module.
- Preview a four-color palette (Black, White, Red, Green) applied to the `basic_html` format.
- Copy the module as a starting template for your own brand palette.
- See how to add palette colors without patching the parent `ckeditor5_fe_color` module.
- See how to keep custom color classes from being stripped by the text-format HTML filter.
- See how `hook_editor_js_settings_alter()` targets a specific text format's FeColor config.
- See how `hook_ckeditor5_plugin_info_alter()` rebuilds a `CKEditor5PluginDefinition` to widen allowed elements.
- See how `hook_library_info_alter()` + `ckeditor5-stylesheets` inject content CSS into the editor.
- Use `css/ckeditor5.css` as a model for CSS-variable-based color definitions (`--color-*`).
- Demonstrate the light-color border option (`hasBorder`) on the White swatch.
- Provide a smoke test that the parent plugin's palette override mechanism works end to end.
- Onboard developers to CKEditor 5 plugin config in Drupal with a concise, real example.
- Serve as documentation-by-code for how palette entries (`label`/`class`/`color`) are shaped.
- Bootstrap a multi-color editor palette quickly on a development or demo site.
- Show how to scope a palette to one format while leaving others on the default two colors.
