Canvas Full HTML swaps the restricted text formats that Drupal Canvas (Experience Builder) uses inside its WYSIWYG component fields for a dedicated, unrestricted `canvas_full_html` text format, so content editors get a fuller CKEditor 5 toolbar in Canvas. It can be toggled on or off from a single settings checkbox.

---

Drupal Canvas ships two locked-down text formats (`canvas_html_block` and `canvas_html_inline`) for rich-text component props, which strip most HTML tags and CKEditor features. This module installs its own `filter.format.canvas_full_html` format plus a matching `editor.editor.canvas_full_html` CKEditor 5 configuration and, while its `enabled` flag is on, intercepts Canvas's prop-shape resolution via `hook_canvas_storable_prop_shape_alter()` to replace those Canvas formats with `canvas_full_html` for any prop whose schema is `contentMediaType: text/html`. It also implements `hook_library_info_alter()` to attach a small `ckeditor-fixes` CSS/JS library (and all enabled CKEditor 5 plugin DLL libraries) to Canvas's `canvas-ui` library, because Canvas bypasses normal page rendering and would otherwise clip toolbar dropdowns and load contrib CKEditor plugins too late. All logic lives in the single autowired hook service `Drupal\canvas_full_html\Hook\CanvasFullHtmlHooks`; the only stored configuration is the boolean `canvas_full_html.settings:enabled` (default TRUE). Turning the setting off makes Canvas fall back to its own restricted formats, and uninstalling the module deletes the `canvas_full_html` filter format entirely. The format's toolbar is a normal CKEditor 5 config you can edit at `/admin/config/content/formats/manage/canvas_full_html`, and both core and contrib (e.g. `ckeditor5_plugin_pack`) plugins are supported.

---

- Give Canvas content editors bold, italic, underline, strikethrough, sub/superscript, headings, links, lists, block quotes, horizontal lines and source editing instead of Canvas's minimal default toolbar.
- Allow full HTML markup inside Drupal Canvas rich-text component props.
- Toggle the enhanced editing experience on or off site-wide with a single checkbox at `/admin/config/content/canvas-full-html`.
- Add a "Source editing" (view/edit raw HTML) button to Canvas WYSIWYG fields.
- Use contrib CKEditor 5 plugins (icons, plugin pack, etc.) inside Canvas editors without extra wiring.
- Customize exactly which CKEditor 5 buttons appear in Canvas by editing the `canvas_full_html` text format at `/admin/config/content/formats/manage/canvas_full_html`.
- Keep the site's regular `full_html` and other formats untouched — changes to the Canvas editor only affect Canvas.
- Fix clipped CKEditor toolbar dropdowns ("Show more items") inside the Canvas React UI.
- Restore Canvas's default restricted formats by unchecking the setting and adding new component instances.
- Provide a Canvas-safe rich text format that excludes the conflicting core CKEditor AJAX integration library.
- Support Drupal 10.3+ and 11 sites that use the Canvas / Experience Builder page builder.
- Standardize rich-text editing across all Canvas components that use `text/html` props.
- Let editors paste and preserve richer markup (headings, quotes, formatted lists) in Canvas blocks.
- Add link editing to Canvas rich-text fields.
- Enable superscript/subscript for footnotes or scientific notation in Canvas content.
- Ship a ready-made text format so no manual text-format setup is needed after install.
- Roll enhanced Canvas editing out to a staging site, evaluate it, and disable it centrally if unwanted.
- Ensure contrib CKEditor plugin DLL chunks finish loading before Canvas's React editor initialises (avoids silent editor crashes).
- Migrate a Canvas site toward richer editorial control without replacing Canvas itself.
- Audit which format a Canvas prop uses by checking whether `canvas_full_html` has replaced `canvas_html_block`/`canvas_html_inline`.
- Give a design/editorial team one text format to restyle for Canvas without touching PHP.
