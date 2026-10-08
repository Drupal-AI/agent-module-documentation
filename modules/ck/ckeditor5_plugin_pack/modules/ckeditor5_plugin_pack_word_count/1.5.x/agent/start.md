# ckeditor5_plugin_pack_word_count — agent start

Submodule of CKEditor 5 Plugin Pack. Registers the **Word Count** CKEditor 5 plugin (class
`src/Plugin/CKEditor5Plugin/WordCount`) — a live word/character counter shown under the editor
(passive, not a toolbar button). Depends on `ckeditor5_plugin_pack`.

Enable, then turn it on / choose which counters to show in the plugin settings for a text format
at **Admin → Config → Content authoring → Text formats and editors**. Config schema
`config/schema/ckeditor5_plugin_pack_word_count.schema.yml`. No standalone admin page.
