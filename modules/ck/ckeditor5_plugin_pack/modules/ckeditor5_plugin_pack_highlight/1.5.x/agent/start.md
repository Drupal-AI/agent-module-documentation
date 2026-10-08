# ckeditor5_plugin_pack_highlight — agent start

Submodule of CKEditor 5 Plugin Pack. Registers the **Highlight** CKEditor 5 plugin (class
`src/Plugin/CKEditor5Plugin/Highlight`) — a marker button with configurable colors. Depends on
`ckeditor5_plugin_pack`.

Enable, then add the Highlight button to a text format toolbar at **Admin → Config → Content
authoring → Text formats and editors**; pick colors in the plugin settings (schema
`config/schema/ckeditor5_plugin_pack_highlight.schema.yml`). `Service/HighlightCssFileCreator`
generates front-end CSS so highlights render on published pages. No standalone admin page.
