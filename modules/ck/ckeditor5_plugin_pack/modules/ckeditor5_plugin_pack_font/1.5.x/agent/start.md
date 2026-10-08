# ckeditor5_plugin_pack_font — agent start

Submodule of CKEditor 5 Plugin Pack. Registers three CKEditor 5 plugins — **Font Family**,
**Font Size**, **Font Color** (text + background) — classes in
`src/Plugin/CKEditor5Plugin/` (`FontFamily`, `FontSize`, `FontColor`). Depends on
`ckeditor5_plugin_pack`.

Enable the module, then add the Font buttons to a text format's toolbar at **Admin → Config →
Content authoring → Text formats and editors**; configure allowed families / sizes / colors in
each plugin's settings (schema `config/schema/ckeditor5_plugin_pack_font.schema.yml`). No
standalone admin page.
